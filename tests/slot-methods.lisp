(defclass test-class (standard-class)
  ())

(defmethod validate-superclass
          ((class test-class)
           (superclass standard-class))
  t)

(defclass test-object () 
  ((slot :initform 5 :accessor a-slot))
  (:metaclass test-class))

(mapc #'acknowledge-function
      '("SLOT-VALUE-USING-CLASS"
        "SLOT-BOUNDP-USING-CLASS"
        "SLOT-MAKUNBOUND-USING-CLASS"
        "SLOT-EXISTS-P-USING-CLASS"))

(acknowledge-setf-function "SLOT-VALUE-USING-CLASS")

(defvar *slot-value-feature* nil)

(defmethod slot-value-using-class :after
  ((class test-class)
   (object t)
   (slot t))
  (when *slot-value-feature*
    (acknowledge *slot-value-feature*)))

(defmethod slot-value-using-class :after
  ((class test-class)
   (object t)
   (slot symbol))
  (acknowledge :slot-value-using-class-specialized-on-symbol))

(defmethod slot-value-using-class :after
  ((class test-class)
   (object t)
   (slot standard-effective-slot-definition))
  (acknowledge :slot-value-using-class-specialized-on-slot-definition))

(defmethod (setf slot-value-using-class) :after
  ((new-value t)
   (class test-class)
   (object t)
   (slot t))
  (when *slot-value-feature*
    (acknowledge *slot-value-feature*)))

(defmethod (setf slot-value-using-class) :after
  ((new-value t)
   (class test-class)
   (object t)
   (slot symbol))
  (acknowledge :setf-slot-value-using-class-specialized-on-symbol))

(defmethod (setf slot-value-using-class) :after
  ((new-value t)
   (class test-class)
   (object t)
   (slot standard-effective-slot-definition))
  (acknowledge :setf-slot-value-using-class-specialized-on-slot-definition))

(defmethod slot-boundp-using-class :after
  ((class test-class)
   (object t)
   (slot t))
  (acknowledge :slot-boundp-calls-slot-boundp-using-class))

(defmethod slot-boundp-using-class :after
  ((class test-class)
   (object t)
   (slot symbol))
  (acknowledge :slot-boundp-using-class-specialized-on-symbol))

(defmethod slot-boundp-using-class :after
  ((class test-class)
   (object t)
   (slot standard-effective-slot-definition))
  (acknowledge :slot-boundp-using-class-specialized-on-slot-definition))

(defmethod slot-makunbound-using-class :after
  ((class test-class)
   (object t)
   (slot t))
  (acknowledge :slot-makunbound-calls-slot-makunbound-using-class))

(defmethod slot-makunbound-using-class :after
  ((class test-class)
   (object t)
   (slot symbol))
  (acknowledge :slot-makunbound-using-class-specialized-on-symbol))

(defmethod slot-makunbound-using-class :after
  ((class test-class)
   (object t)
   (slot standard-effective-slot-definition))
  (acknowledge :slot-makunbound-using-class-specialized-on-slot-definition))

(defmethod slot-exists-p-using-class :after
  ((class test-class)
   (object t)
   (slot t))
  (acknowledge :slot-exists-p-calls-slot-exists-p-using-class))

(defmethod slot-exists-p-using-class :after
  ((class test-class)
   (object t)
   (slot symbol))
  (acknowledge :slot-exists-p-using-class-specialized-on-symbol))

(defmethod slot-exists-p-using-class :after
  ((class test-class)
   (object t)
   (slot standard-effective-slot-definition))
  (acknowledge :slot-exists-p-using-class-specialized-on-slot-definition))

(let ((object (make-instance 'test-object)))
  (let ((*slot-value-feature* :slot-value-calls-slot-value-using-class))
    (slot-value object 'slot))
  (let ((*slot-value-feature* :slot-reader-calls-slot-value-using-class))
    (a-slot object))
  (let ((*slot-value-feature* :setf-slot-value-calls-setf-slot-value-using-class))
    (setf (slot-value object 'slot) 42))
  (let ((*slot-value-feature* :slot-writer-calls-slot-value-using-class))
    (setf (a-slot object) 4711))
  (slot-boundp object 'slot)
  (slot-makunbound object 'slot)
  (slot-exists-p object 'slot))
