(let ((gf (make-instance 'standard-generic-function
                         :lambda-list
                         #-allegro '(a b c &optional o)
                         #+allegro '(a b c))))
  (when (equal (generic-function-argument-precedence-order gf) '(a b c))
    (acknowledge :initialize-lambda-list-initializes-argument-precedence-order)))

(let ((gf (make-instance 'standard-generic-function
                         :lambda-list
                         #-allegro '(a b c &optional o)
                         #+allegro '(a b c)
                         :argument-precedence-order '(c b a))))
  (assert (equal (generic-function-argument-precedence-order gf) '(c b a)))
  (reinitialize-instance gf
                         :lambda-list
                         #-allegro '(a b c &rest r)
                         #+allegro '(a b c))
  (when (equal (generic-function-argument-precedence-order gf) '(a b c))
    (acknowledge :reinitialize-lambda-list-reinitializes-argument-precedence-order)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defclass test-generic-function (standard-generic-function) ()
    (:metaclass funcallable-standard-class))

  (defclass test-method (standard-method) ())

  (defvar *reinitialize-action* nil)
  (defvar *defmethod-called-p* nil)
  (defvar *add-method-called-p* nil)
  (defvar *the-feature* :initialize-instance-calls-compute-discriminating-function)
  (defvar *the-function* nil)

  (defmethod reinitialize-instance :after
    ((function test-generic-function) &key name &allow-other-keys)
    (when *reinitialize-action*
      (funcall *reinitialize-action* function name)))

  (defvar *check-find-method-combination* t)

  (defmethod find-method-combination :after
    ((function test-generic-function)
     (method-combination-type-name t)
     (method-combination-options t))
    (when *check-find-method-combination*
      (acknowledge :defgeneric-calls-find-method-combination)))

  (acknowledge-function "ENSURE-GENERIC-FUNCTION-USING-CLASS")

  (defmethod ensure-generic-function-using-class :after
    ((function test-generic-function) (name t) &rest initargs)
    (declare (ignore initargs))
    (acknowledge :defgeneric-calls-ensure-generic-function-using-class))

  (defmethod initialize-instance :before
    ((class test-generic-function) &rest initargs)
    (loop for (key nil) on initargs by #'cddr
          do (acknowledge (intern (concatenate 
                                   'string "GENERIC-FUNCTION-INITIALIZED-WITH-"
                                   (symbol-name key))
                                  :keyword))))

  (defmethod initialize-instance :before
    ((method test-method) &rest initargs)
    (declare (ignore initargs))
    (when *defmethod-called-p*
      (acknowledge :defmethod-calls-initialize-instance)))

  #-scl
  (when (mop-function-p "MAKE-METHOD-LAMBDA")
    (if (= (length (generic-function-lambda-list #'make-method-lambda)) 4)
        (progn
          (acknowledge :make-method-lambda)
          (defmethod make-method-lambda :after
            ((function test-generic-function)
             (method standard-method)
             (lambda-expression t)
             (environment t))
            (when *defmethod-called-p*
              (acknowledge :defmethod-calls-make-method-lambda))))
      (progn
        #+lispworks
        (acknowledge :make-method-lambda-lispworks)
        #-lispworks
        (error "unknown kind of make-method-lambda.")
        (defmethod make-method-lambda :after
          ((function test-generic-function)
           (method standard-method)
           (lambda-list t)
           (declarations t)
           (body t)
           &optional env)
          (when *defmethod-called-p*
            (acknowledge :defmethod-calls-make-method-lambda))))))

  (when (typep #'compute-applicable-methods 'generic-function)
    (acknowledge :compute-applicable-methods-is-generic)
    (defmethod compute-applicable-methods :after
      ((gf test-generic-function) args)
      (acknowledge :function-invocation-calls-compute-applicable-methods)))

  (when (mop-function-p "COMPUTE-APPLICABLE-METHODS-USING-CLASSES")
    (defmethod compute-applicable-methods-using-classes :after
      ((gf test-generic-function) classes)
      (acknowledge :function-invocation-calls-compute-applicable-methods-using-classes)))

  (when (mop-function-p "COMPUTE-EFFECTIVE-METHOD")
    (acknowledge :compute-effective-method)
    (when (typep #'compute-effective-method 'generic-function)
      (acknowledge :compute-effective-method-is-generic)
      (defmethod compute-effective-method :after
	  ((gf test-generic-function)
	   (method-combination t)
	   (methods t))
	(acknowledge :function-invocation-calls-compute-effective-method))))

  (defmethod compute-discriminating-function :after
    ((function test-generic-function) #+scl cache)
    #+scl (declare (ignore cache))
    (when *the-feature*
      (acknowledge *the-feature*)))

  (when (typep #'find-method 'generic-function)
    (acknowledge :find-method-is-generic)
    (defmethod find-method :after
      ((function test-generic-function)
       qualifiers specializers &optional errp)
      (declare (ignore qualifiers specializers errp))
      (when *add-method-called-p*
        (acknowledge :add-method-calls-find-method))))

  (when (typep #'remove-method 'generic-function)
    (acknowledge :remove-method-is-generic)
    (defmethod remove-method :after
      ((function test-generic-function)
       (method standard-method))
      (when *add-method-called-p*
        (acknowledge :add-method-calls-remove-method))))

  (defmethod add-method :before
    ((function test-generic-function)
     (method standard-method))
    (when *defmethod-called-p*
      (acknowledge :defmethod-calls-add-method)))

  (defmethod add-method :around
    ((function test-generic-function)
     (method standard-method))
    (let ((*add-method-called-p* t))
      (call-next-method)))

  (when (typep #'generic-function-method-class 'generic-function)
    (acknowledge :generic-function-method-class-is-generic)
    (defmethod generic-function-method-class :after ((function test-generic-function))
      (when (and *defmethod-called-p*
                 (eq function *the-function*))
        (acknowledge :defmethod-calls-generic-function-method-class)))))

(when (mop-function-p "FIND-METHOD-COMBINATION")
  (handler-case
      (progn
        (let ((*check-find-method-combination* nil))
          (find-method-combination
           (ensure-generic-function (gensym)
                                    :generic-function-class 'test-generic-function)
           'standard ()))
        (acknowledge :find-method-combination))
    (error () nil)))

(defgeneric test-function-nil ()
  (:generic-function-class test-generic-function))

(defgeneric test-function (x)
  (:generic-function-class test-generic-function)
  (:method-class test-method))

(setf *the-function* #'test-function)

(defvar *the-method*
  #-(or clozure scl)
  (make-instance 'standard-method
                 :qualifiers '()
                 :lambda-list '()
                 :specializers '()
                 :function
                 #+(or openmcl mcl) (lambda () nil)
                 #+sbcl (lambda (&rest args)
                          (declare (ignore args))
                          nil)
                 #-(or openmcl mcl sbcl) (constantly nil))
  #+scl
  (make-instance 'standard-method
                 :qualifiers '()
                 :lambda-list '()
                 :specializers '()
                 :function (constantly (constantly nil)))
  #+(and clozure (not closer-mop))
  (make-instance 'standard-method
                 :qualifiers '()
                 :lambda-list '()
                 :specializers '()
                 :function (lambda () nil))
  #+(and clozure closer-mop)
  (make-instance 'standard-method
                 :qualifiers '()
                 :lambda-list '()
                 :specializers '()
                 :function (lambda (&rest args)
                             (declare (ignore args))
                             nil)
                 :closer-patch t))

(let ((*the-feature* :add-method-calls-compute-discriminating-function))
  (add-method #'test-function-nil *the-method*))

(let ((*the-feature* :function-invocation-calls-compute-discriminating-function))
  (test-function-nil))

(let ((*the-feature* :reinitialize-instance-calls-compute-discriminating-function))
  (reinitialize-instance #'test-function-nil))

(let ((*the-feature* :remove-method-calls-compute-discriminating-function))
  (remove-method #'test-function-nil *the-method*))

(setf *the-feature* nil)

(let ((*defmethod-called-p* t))
  (eval '(defmethod test-function ((x integer)) nil)))

(let ((*defmethod-called-p* t))
  (eval '(defmethod test-function ((x integer)) x)))

(defmethod test-function ((x (eql 5))) 42)

(test-function 5)

(defgeneric test-function-2 (x y)
  (:generic-function-class test-generic-function)
  (:argument-precedence-order y x)
  (declare (optimize speed))
  (:documentation "a function")
  (:method-combination +)
  #-(or clozure mcl)
  (:method-class test-method)
  (:method + (x y) (+ x y)))

#|
(mapc #'acknowledge-function
      '("GENERIC-FUNCTION-ARGUMENT-PRECEDENCE-ORDER"
        "GENERIC-FUNCTION-DECLARATIONS"
        "GENERIC-FUNCTION-LAMBDA-LIST"
        "GENERIC-FUNCTION-METHOD-CLASS"
        "GENERIC-FUNCTION-METHOD-COMBINATION"
        "GENERIC-FUNCTION-METHODS"
        "GENERIC-FUNCTION-NAME"))
|#

(defgeneric test-function-3 (x)
  (:generic-function-class test-generic-function))

(defgeneric test-function-3 (x)
  (:generic-function-class test-generic-function))

(defmethod test-function-3 (x)
  (declare (ignore x))
  (print 'hi))

(add-method #'test-function-3
            (make-instance 'standard-method
                           :qualifiers '()
                           :lambda-list '(x)
                           :specializers (list (find-class 't))
                           :function (lambda (x) x)))

(handler-case
    (progn
      (test-function-3 42)
      (acknowledge :method-functions-take-original-parameters))
  (error () (acknowledge :method-functions-take-processed-parameters)))

(cond ((member :make-method-lambda-lispworks *mop-features*)
       (acknowledge :method-lambdas-are-processed))

      ((member :make-method-lambda *mop-features*)
       (let ((method-lambda '(lambda (x) x)))
         (if (eq method-lambda
                 (make-method-lambda
                  #'test-function (class-prototype (find-class 'standard-method))
                  method-lambda nil))
             (acknowledge :method-lambdas-are-unchanged)
           (acknowledge :method-lambdas-are-processed)))))

(when (mop-setf-function-p "GENERIC-FUNCTION-NAME")
  (acknowledge :setf-generic-function-name)

  (let ((*reinitialize-action*
         (lambda (function name)
           (when (and (eq function #'test-function-3)
                      (eq name 'test-function-4))
             (acknowledge :setf-generic-function-name-calls-reinitialize-instance)))))
    (setf (generic-function-name #'test-function-3)
          'test-function-4)))

#+lispworks4.3
(defmethod compute-discriminating-function ((function t))
  (let ((previous nil))
    (lambda (&rest args)
      (let ((old previous))
        (setq previous (car args))
        old))))

#-(or cmu clozure mcl)
(progn
  (defgeneric test-function-5 (object)
    (:generic-function-class test-generic-function))

  (defmethod test-function-5 (object) object)

  #-scl
  (let ((function (compute-discriminating-function #'test-function-5)))
    (handler-case
        (when (eql (funcall function 4711) 4711)
          (acknowledge :discriminating-functions-can-be-funcalled))
      (error ())))

  (defmethod compute-discriminating-function ((function test-generic-function) #+scl cache)
    #+scl (declare (ignore cache))
    (let ((previous nil))
      (lambda (&rest args)
        (let ((old previous))
          (setq previous (car args))
          old))))

  #-scl
  (set-funcallable-instance-function
   #'test-function-5 (compute-discriminating-function #'test-function-5))

  #+scl
  (defmethod test-function-5 (object) object)

  (handler-case
      (when (and (eql (test-function-5 0815) nil)
                 (eql (test-function-5 666) 0815))
        (acknowledge :discriminating-functions-can-be-closures))
    (error ())))

#+(and clozure closer-mop)
(progn
  (defgeneric test-function-5 (object)
    (:generic-function-class test-generic-function))

  (defmethod test-function-5 (object) object)
  
  (let ((function (compute-discriminating-function #'test-function-5)))
    (handler-case
        (when (eql (funcall function 4711) 4711)
          (acknowledge :discriminating-functions-can-be-funcalled))
      (error ())))

  (defmethod compute-discriminating-function ((function test-generic-function))
    (let ((previous nil))
      (lambda (&rest args)
        (let ((old previous))
          (setq previous (car args))
          old))))

  (set-funcallable-instance-function
   #'test-function-5 (compute-discriminating-function #'test-function-5))

  (handler-case
      (when (and (eql (test-function-5 0815) nil)
                 (eql (test-function-5 666) 0815))
        (acknowledge :discriminating-functions-can-be-closures))
    (error ())))


(defmethod compute-discriminating-function
           ((gf test-generic-function) #+scl cache)
  #+scl (declare (ignore cache))
  (lambda () 'hello-world))

(defgeneric test-function-6 ()
  (:generic-function-class test-generic-function))

(handler-case
    (when (eq (test-function-6) 'hello-world)
      (acknowledge :generic-functions-can-be-empty))
  (error ()))

#-mcl
(progn 
  (defgeneric test-function-7 (x y z))

  (set-funcallable-instance-function
   #'test-function-7 (lambda (x y z) (* x y z)))

  (handler-case
      (when (and (eql (test-function-7 2 3 4) (* 2 3 4))
		 (eql (test-function-7 10 20 30) (* 10 20 30)))
	(acknowledge :funcallable-instance-functions-can-be-closures))
    (error ())))
