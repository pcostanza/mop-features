(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(defvar *mode*)

(defmethod initialize-instance :around
  ((class test-class) &rest initargs)
  (if *mode*
      (loop for (key value) on initargs by #'cddr
            do (acknowledge (intern (concatenate 
                                     'string "CLASS-INITIALIZED-WITH-"
                                     (symbol-name key))
                                    :keyword)))
    (let ((direct-superclasses (getf initargs :direct-superclasses)))
      (cond ((null direct-superclasses) 
             (acknowledge :direct-superclasses-by-default-empty))

            ((eq 'standard-object (car direct-superclasses))
             (acknowledge :direct-superclasses-by-default-standard-symbol))

            ((eq (find-class 'standard-object) (car direct-superclasses))
             (acknowledge :direct-superclasses-by-default-standard-metaobject)))))
  (call-next-method))

(setf *mode* nil)

(defclass test1 () ()
  (:metaclass test-class))

(setf *mode* t)

(defclass test2 (test1)
  ((some-slot :initarg :some-slot :accessor some-slot))
  (:documentation "a class")
  (:default-initargs :some-slot 42)
  (:metaclass test-class))

#|
(mapc #'acknowledge-function
      '("CLASS-DEFAULT-INITARGS"
        "CLASS-DIRECT-DEFAULT-INITARGS"
        "CLASS-DIRECT-SLOTS"
        "CLASS-DIRECT-SUBCLASSES"
        "CLASS-DIRECT-SUPERCLASSES"
        "CLASS-FINALIZED-P"
        "CLASS-PRECEDENCE-LIST"
        "CLASS-PROTOTYPE"))
|#
