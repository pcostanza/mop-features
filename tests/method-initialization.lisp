(defclass test-method (standard-method) ())

(defmethod initialize-instance :before
  ((class test-method) &rest initargs)
  (loop for (key nil) on initargs by #'cddr
        do (acknowledge (intern (concatenate 
                                 'string *init-prefix*
                                 (symbol-name key))
                                :keyword))))

(defgeneric test-function (x)
  (:generic-function-class standard-generic-function)
  (:method-class test-method))

(defparameter *init-prefix* "METHOD-INITIALIZED-WITH-")

(defmethod test-function :after (x)
  (declare (optimize speed))
  "a method"
  (print x))

(makunbound '*init-prefix*)

(when (find-class 'standard-reader-method nil)
  (defclass test-reader-method
            (standard-reader-method test-method)
    ())

  (defclass test-class (standard-class)
    ())

  (defmethod validate-superclass
             ((class test-class)
              (superclass standard-class))
    t)

  (defmethod reader-method-class
             ((class test-class) (direct-slot t) &rest initargs)
    (declare (ignore initargs))
    (find-class 'test-reader-method))

  (defparameter *init-prefix* "ACCESSOR-METHOD-INITIALIZED-WITH-")
  
  (defclass test ()
    ((some-slot :reader test-function))
    (:metaclass test-class)))

#|
(mapc #'acknowledge-function
      '("METHOD-FUNCTION"
        "METHOD-GENERIC-FUNCTION"
        "METHOD-LAMBDA-LIST"
        "METHOD-SPECIALIZERS"
        "METHOD-QUALIFIERS"
        "ACCESSOR-METHOD-SLOT-DEFINITION"))
|#
