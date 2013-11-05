(acknowledge-function "VALIDATE-SUPERCLASS")

(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(defclass test-object-1 () ()
  (:metaclass test-class))

(defclass test-object-2 () ()
  (:metaclass test-class))

(defclass test-object () (some-slot))

(unless (class-finalized-p (find-class 'test-object-1))
  (finalize-inheritance (find-class 'test-object-1)))
(unless (class-finalized-p (find-class 'test-object-2))
  (finalize-inheritance (find-class 'test-object-2)))
(unless (class-finalized-p (find-class 'test-object))
  (finalize-inheritance (find-class 'test-object)))

(defclass test-function () ()
  (:metaclass funcallable-standard-class))

(unless (class-finalized-p (find-class 'test-function))
  (finalize-inheritance (find-class 'test-function)))

(when (validate-superclass (find-class 'test-object-1) (find-class 't))
  (acknowledge :t-is-always-a-valid-superclass))

(when (validate-superclass (find-class 'test-object-1)
                           (find-class 'test-object-2))
  (acknowledge :classes-are-always-their-own-valid-superclasses))

(when (validate-superclass (find-class 'test-function)
                           (find-class 'test-object))
  (acknowledge :standard-class-and-funcallable-standard-class-are-compatible))
