(defclass xjcl-class (standard-class) ())

(defmethod validate-superclass ((class xjcl-class) (superclass standard-class)) t)

(defclass xjcl-direct-slot-definition (standard-direct-slot-definition) ())

(defmethod direct-slot-definition-class ((class xjcl-class) &rest initargs)
  (declare (ignore initargs))
  (find-class 'xjcl-direct-slot-definition))

(defclass xjcl-effective-slot-definition (standard-effective-slot-definition) ())

(defvar *effective-slot-definition-class*)

(defmethod compute-effective-slot-definition
           ((class xjcl-class) (name t) direct-slot-definitions)
  (let ((*effective-slot-definition-class*
         (if (eq (slot-definition-allocation (first direct-slot-definitions)) :xjcl)
           (find-class 'xjcl-effective-slot-definition)
           (find-class 'standard-effective-slot-definition))))
    (call-next-method)))

(defmethod effective-slot-definition-class
           ((class xjcl-class) &rest initargs)
  (declare (ignore initargs))
  *effective-slot-definition-class*)

(ignore-errors
  (eval '(progn
           (defclass test-object ()
             ((test-slot :allocation :xjcl))
             (:metaclass xjcl-class))
           (unless (class-finalized-p (find-class 'test-object))
             (finalize-inheritance (find-class 'test-object)))))
  (let ((slotd (find 'test-slot (class-slots (find-class 'test-object))
                     :key #'slot-definition-name)))
    (when (typep slotd 'xjcl-effective-slot-definition)
      (acknowledge :extensible-allocation))))
