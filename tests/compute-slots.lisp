(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(defvar *finalize-inheritance-called* nil)

(defmethod finalize-inheritance
           ((class test-class))
  (let ((*finalize-inheritance-called* t))
    (call-next-method)))

(mapc #'acknowledge-function
      '("COMPUTE-SLOTS"
        "COMPUTE-EFFECTIVE-SLOT-DEFINITION"
        "DIRECT-SLOT-DEFINITION-CLASS"
        "EFFECTIVE-SLOT-DEFINITION-CLASS"
        "READER-METHOD-CLASS"
        "WRITER-METHOD-CLASS"))

(defmethod compute-slots :after
  ((class test-class))
  (acknowledge (if *finalize-inheritance-called*
                   :finalize-inheritance-calls-compute-slots
                 :class-initialization-calls-compute-slots)))

(defmethod compute-effective-slot-definition :after
  ((class test-class) (name t) (direct-slot-definitions t))
  (acknowledge (if *finalize-inheritance-called*
                   :finalize-inheritance-calls-compute-effective-slot-definition
                 :class-initialization-calls-compute-effective-slot-definition)))

(defmethod direct-slot-definition-class :after
  ((class test-class) &rest initargs)
  (declare (ignore initargs))
  (acknowledge (if *finalize-inheritance-called*
                   :finalize-inheritance-calls-direct-slot-definition-class
                 :class-initialization-calls-direct-slot-definition-class)))

(defmethod effective-slot-definition-class :after
  ((class test-class) &rest initargs)
  (declare (ignore initargs))
  (acknowledge (if *finalize-inheritance-called*
                   :finalize-inheritance-calls-effective-slot-definition-class
                 :class-initialization-calls-effective-slot-definition-class)))

(when (mop-function-p "READER-METHOD-CLASS")
  (defmethod reader-method-class :after
    ((class test-class) (direct-slot t) &rest initargs)
    (declare (ignore initargs))
    (acknowledge (if *finalize-inheritance-called*
                     :finalize-inheritance-calls-reader-method-class
                   :class-initialization-calls-reader-method-class))))

(when (mop-function-p "WRITER-METHOD-CLASS")
  (defmethod writer-method-class :after
    ((class test-class) (direct-slot t) &rest initargs)
    (declare (ignore initargs))
    (acknowledge (if *finalize-inheritance-called*
                     :finalize-inheritance-calls-writer-method-class
                   :class-initialization-calls-writer-method-class))))

(defclass test-object ()
  ((name :accessor name))
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-object))
  (finalize-inheritance (find-class 'test-object)))
