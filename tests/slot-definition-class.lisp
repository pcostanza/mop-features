(defclass my-class (standard-class)
  ())

(defmethod validate-superclass
           ((class my-class) (superclass standard-class))
  t)

(defclass my-slot-definition () ())

(defclass my-direct-slot-definition
          (my-slot-definition standard-direct-slot-definition)
  ())

(defclass my-effective-slot-definition
          (my-slot-definition standard-effective-slot-definition)
  ())

(defmethod initialize-instance :after
  ((slotd my-slot-definition)
   &rest initargs
   &key bla blubb
   &allow-other-keys)
  (declare (ignore initargs bla blubb))
  ())

(defmethod direct-slot-definition-class
           ((class my-class)
            &rest all-args
            &key (name nil name-p)
            (initargs nil initargs-p)
            (initform nil initform-p)
            (initfunction nil initfunction-p)
            (readers nil readers-p)
            (writers nil writers-p)
            (documentation nil documentation-p)
            (allocation nil allocation-p)
            (type nil type-p)
            (bla nil bla-p)
            (blubb nil blubb-p)
            &allow-other-keys)
  (if (and name-p (eq name 'test))
      (acknowledge :name-passed-to-direct-slot-definition-class)
    (return-from direct-slot-definition-class
      (find-class 'my-direct-slot-definition)))
  (when (and initargs-p (member :test initargs))
    (acknowledge :initargs-passed-to-direct-slot-definition-class))
  (when (and initform-p (equal initform '(+ 2 2)))
    (acknowledge :initform-passed-to-direct-slot-definition-class))
  (when initfunction-p
    (acknowledge :initfunction-passed-to-direct-slot-definition-class))
  (when (and readers-p
             (member 'test readers)
             (member 'get-test readers))
    (acknowledge :readers-passed-to-direct-slot-definition-class))
  (when (and writers-p
             (member '(setf test) writers :test #'equal)
             (member 'set-test writers))
    (acknowledge :writers-passed-to-direct-slot-definition-class))
  (when documentation-p
    (acknowledge :documentation-passed-to-direct-slot-definition-class))
  (when allocation-p
    (acknowledge :allocation-passed-to-direct-slot-definition-class))
  (when type-p
    (acknowledge :type-passed-to-direct-slot-definition-class))
  (when bla-p
    (cond ((and (listp bla) (member 1 bla) (member 2 bla))
           (acknowledge :multiple-slot-options-passed-as-list-to-direct-slot-definition-class))
          ((multiple-value-bind
               (indicator value1 tail)
               (get-properties all-args '(:bla))
             (multiple-value-bind
                 (indicator value2 tail)
                 (get-properties (cddr tail) '(:bla))
               (or (and (eql value1 1)
                        (eql value2 2))
                   (and (eql value2 1)
                        (eql value1 2)))))
           (acknowledge :multiple-slot-options-passed-as-singletons-to-direct-slot-definition-class))))
  (when blubb-p
    (cond ((eql blubb 3)
           (acknowledge :single-slot-options-passed-as-singletons-to-direct-slot-definition-class))
          ((and (listp blubb) (member 3 blubb))
           (acknowledge :single-slot-options-passed-as-list-to-direct-slot-definition-class))))
  (loop for (key nil) on all-args by #'cddr
        unless (member key '(:name :initargs :initform :initfunction :readers :writers
                             :documentation :allocation :type :bla :blubb))
        do (acknowledge (intern (concatenate 'string
                                             (symbol-name key)
                                             "-PASSED-TO-DIRECT-SLOT-DEFINITION-CLASS")
                                :keyword)))
  (find-class 'my-direct-slot-definition))

(defmethod effective-slot-definition-class
           ((class my-class)
            &rest all-args
            &key (name nil name-p)
            (initargs nil initargs-p)
            (initform nil initform-p)
            (initfunction nil initfunction-p)
            (readers nil readers-p)
            (writers nil writers-p)
            (documentation nil documentation-p)
            (allocation nil allocation-p)
            (type nil type-p)
            (bla nil bla-p)
            (blubb nil blubb-p)
            &allow-other-keys)
  (if (and name-p (eq name 'test))
      (acknowledge :name-passed-to-effective-slot-definition-class)
    (return-from effective-slot-definition-class
      (find-class 'my-direct-slot-definition)))
  (when (and initargs-p (member :test initargs))
    (acknowledge :initargs-passed-to-effective-slot-definition-class))
  (when (and initform-p (equal initform '(+ 2 2)))
    (acknowledge :initform-passed-to-effective-slot-definition-class))
  (when initfunction-p
    (acknowledge :initfunction-passed-to-effective-slot-definition-class))
  (when (and readers-p
             (member 'test readers)
             (member 'get-test readers))
    (acknowledge :readers-passed-to-effective-slot-definition-class))
  (when (and writers-p
             (member '(setf test) writers :test #'equal)
             (member 'set-test writers))
    (acknowledge :writers-passed-to-effective-slot-definition-class))
  (when documentation-p
    (acknowledge :documentation-passed-to-effective-slot-definition-class))
  (when allocation-p
    (acknowledge :allocation-passed-to-effective-slot-definition-class))
  (when type-p
    (acknowledge :type-passed-to-effective-slot-definition-class))
  (when bla-p
    (cond ((and (listp bla) (member 1 bla) (member 2 bla))
           (acknowledge :multiple-slot-options-passed-as-list-to-effective-slot-definition-class))
          ((multiple-value-bind
               (indicator value1 tail)
               (get-properties all-args '(:bla))
             (multiple-value-bind
                 (indicator value2 tail)
                 (get-properties tail '(:bla))
               (or (and (eql value1 1)
                        (eql value2 2))
                   (and (eql value2 1)
                        (eql value1 2)))))
           (acknowledge :multiple-slot-options-passed-as-singletons-to-effective-slot-definition-class))))
  (when blubb-p
    (cond ((eql blubb 3)
           (acknowledge :single-slot-options-passed-as-singletons-to-effective-slot-definition-class))
          ((and (listp blubb) (member 3 blubb))
           (acknowledge :single-slot-options-passed-as-list-to-effective-slot-definition-class))))     
  (loop for (key nil) on all-args by #'cddr
        unless (member key '(:name :initargs :initform :initfunction :readers :writers
                             :documentation :allocation :type :bla :blubb))
        do (acknowledge (intern (concatenate 'string
                                             (symbol-name key)
                                             "-PASSED-TO-EFFECTIVE-SLOT-DEFINITION-CLASS")
                                :keyword)))
  (find-class 'my-effective-slot-definition))

(defclass test ()
  ((test :initform (+ 2 2)
         :initarg :test
         :accessor test
         :reader get-test
         :writer set-test
         :documentation "This is a test!"
         :allocation :class
         :type integer
         :bla 1 :bla 2 :blubb 3))
  (:metaclass my-class))

(unless (class-finalized-p (find-class 'test))
  (finalize-inheritance (find-class 'test)))
