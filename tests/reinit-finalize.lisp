(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(defvar *finalize-inheritance-count* 0)

(defmethod finalize-inheritance :before
  ((class test-class))
  (incf *finalize-inheritance-count*)
  (when (> *finalize-inheritance-count* 1)
    (acknowledge :reinitialize-instance-calls-finalize-inheritance)))

(defclass test-object ()
  ((a-slot))
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-object))
  (finalize-inheritance (find-class 'test-object)))

(reinitialize-instance (find-class 'test-object))
