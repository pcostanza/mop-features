(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(acknowledge-function "COMPUTE-CLASS-PRECEDENCE-LIST")

(defmethod compute-class-precedence-list :after
  ((class test-class))
  (acknowledge :finalize-inheritance-calls-compute-class-precedence-list))

(when (mop-function-p "COMPUTE-DEFAULT-INITARGS")
  #+(and allegro (not (version>= 8 2)))
  (acknowledge :compute-default-initargs-allegro)
  #-(and allegro (not (version>= 8 2)))
  (acknowledge :compute-default-initargs)
  #-(and allegro (not (version>= 8 2)))
  (defmethod compute-default-initargs :after
    ((class test-class))
    (acknowledge :finalize-inheritance-calls-compute-default-initargs))
  #+(and allegro (not (version>= 8 2)))
  (defmethod compute-default-initargs :after
    ((class test-class) (cpl t) (direct t))
    (acknowledge :finalize-inheritance-calls-compute-default-initargs)))

(defclass test-object (standard-object) ()
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-object))
  (finalize-inheritance (find-class 'test-object)))
