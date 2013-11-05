(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(acknowledge-function "ENSURE-CLASS-USING-CLASS")

;; only when reinitialized:
(defmethod ensure-class-using-class :after
  ((class test-class) (name t) &rest initargs)
  (declare (ignore initargs))
  (acknowledge :class-reinitialization-calls-ensure-class-using-class))

(defmethod change-class :before
  ((class forward-referenced-class)
   (new-class (eql (find-class 'test-class)))
   &rest initargs)
  (declare (ignore initargs))
  (acknowledge :forward-referenced-class-changed-by-change-class))

(defclass test-sub (test-super) ()
  (:metaclass test-class))

(defclass test-super () ()
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-sub))
  (finalize-inheritance (find-class 'test-sub)))

(defclass test-sub () ()
  (:metaclass test-class))
