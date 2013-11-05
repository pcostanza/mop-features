(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(acknowledge-function "FINALIZE-INHERITANCE")

(defmethod finalize-inheritance :after
  ((class test-class))
  (acknowledge :make-instance-calls-finalize-inheritance))

(defclass test-object () ()
  (:metaclass test-class))

(make-instance 'test-object)
