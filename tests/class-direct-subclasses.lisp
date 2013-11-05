(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(acknowledge-function "ADD-DIRECT-SUBCLASS")
(acknowledge-function "REMOVE-DIRECT-SUBCLASS")

(defmethod add-direct-subclass :after
  ((superclass test-class)
   (subclass test-class))
  (acknowledge :class-reinitialization-calls-add-direct-subclass))

(defmethod remove-direct-subclass :after
  ((superclass test-class)
   (subclass test-class))
  (acknowledge :class-reinitialization-calls-remove-direct-subclass))

(defclass test-super () ()
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-super))
  (finalize-inheritance (find-class 'test-super)))

(defclass test-sub (test-super) ()
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-sub))
  (finalize-inheritance (find-class 'test-sub)))

;(acknowledge-function "CLASS-DIRECT-SUBCLASSES")

(when (and (mop-function-p "CLASS-DIRECT-SUBCLASSES")
           (member (find-class 'test-sub)
                   (class-direct-subclasses (find-class 'test-super))))
  (acknowledge :class-direct-subclasses-returns-direct-subclasses))

(reinitialize-instance 
 (find-class 'test-sub)
 :direct-superclasses (list (find-class 'standard-object)))
