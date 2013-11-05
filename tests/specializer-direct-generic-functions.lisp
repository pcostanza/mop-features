(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(defclass test-object (standard-object) ()
  (:metaclass test-class))

(acknowledge-function "ADD-DIRECT-METHOD")

(defmethod add-direct-method :after
  ((class test-class)
   (method standard-method))
  (acknowledge :add-method-calls-add-direct-method))

(acknowledge-function "REMOVE-DIRECT-METHOD")

(defmethod remove-direct-method :after
  ((class test-class)
   (method standard-method))
  (acknowledge :remove-method-calls-remove-direct-method))

(let ((the-function (ensure-generic-function 'test :lambda-list '(object)
                                             :generic-function-class (find-class 'standard-generic-function)))
      (the-method (make-instance 'standard-method
                                 :qualifiers '()
                                 :lambda-list '(object)
                                 :specializers (list (find-class 'test-object))
                                 :function 
                                 #+(or clozure mcl) (lambda (object) nil)
                                 #-(or clozure mcl) (constantly nil))))
  (add-method the-function the-method)
  (acknowledge-function "SPECIALIZER-DIRECT-METHODS")
  (when (and (mop-function-p "SPECIALIZER-DIRECT-METHODS")
             (member the-method (specializer-direct-methods
                                 (find-class 'test-object))))
    (acknowledge :add-method-updates-specializer-direct-methods))
  (acknowledge-function "SPECIALIZER-DIRECT-GENERIC-FUNCTIONS")
  (when (and (mop-function-p "SPECIALIZER-DIRECT-GENERIC-FUNCTIONS")
             (member (symbol-function 'test) 
                     (specializer-direct-generic-functions
                      (find-class 'test-object))))
    (acknowledge :add-method-updates-specializer-direct-generic-functions))
  (remove-method the-function the-method))
