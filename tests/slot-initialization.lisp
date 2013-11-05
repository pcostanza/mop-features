(defclass test-direct-slot-definition
          (standard-direct-slot-definition)
  ())

(defclass test-effective-slot-definition
          (standard-effective-slot-definition)
  ())

(defmethod initialize-instance :before
  ((class test-direct-slot-definition) &rest initargs)
  (loop for (key nil) on initargs by #'cddr
        do (acknowledge (intern (concatenate 
                                 'string "DIRECT-SLOT-DEFINITION-INITIALIZED-WITH-"
                                 (symbol-name key))
                                :keyword))))

(defmethod initialize-instance :before
  ((class test-effective-slot-definition) &rest initargs)
  (loop for (key nil) on initargs by #'cddr
        do (acknowledge (intern (concatenate 
                                 'string "EFFECTIVE-SLOT-DEFINITION-INITIALIZED-WITH-"
                                 (symbol-name key))
                                :keyword))))

(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(defmethod direct-slot-definition-class
           ((class test-class) &rest initargs)
  (declare (ignore initargs))
  (find-class 'test-direct-slot-definition))

(defmethod effective-slot-definition-class
           ((class test-class) &rest initargs)
  (declare (ignore initargs))
  (find-class 'test-effective-slot-definition))

(defclass test-object ()
  ((some-slot :accessor some-slot
              :initarg :some-slot
              :initform 'some-slot
              :type symbol
              :allocation :class
              :documentation "a slot"))
  (:metaclass test-class))

(unless (class-finalized-p (find-class 'test-object))
  (finalize-inheritance (find-class 'test-object)))

#|
(mapc #'acknowledge-function
      '("SLOT-DEFINITION-ALLOCATION"
        "SLOT-DEFINITION-INITARGS"
        "SLOT-DEFINITION-INITFORM"
        "SLOT-DEFINITION-INITFUNCTION"
        "SLOT-DEFINITION-NAME"
        "SLOT-DEFINITION-TYPE"
        "SLOT-DEFINITION-READERS"
        "SLOT-DEFINITION-WRITERS"
        "SLOT-DEFINITION-LOCATION"))
|#
