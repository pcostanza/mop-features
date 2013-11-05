(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(defmethod initialize-instance :before
  ((class test-class) &rest initargs)
  (declare (ignore initargs))
  (acknowledge :defclass-calls-initialize-instance))

(defmethod reinitialize-instance :before
  ((class test-class) &rest initargs)
  (declare (ignore initargs))
  (acknowledge :defclass-calls-reinitialize-instance))

(defclass test-object ()
  ()
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-object))
  (finalize-inheritance (find-class 'test-object)))

(defclass test-object ()
  (some-slot)
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-object))
  (finalize-inheritance (find-class 'test-object)))


