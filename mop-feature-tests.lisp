(in-package :mop-feature-tests)

(defparameter *mop-package-name*
  #+abcl "MOP"
  #+allegro "MOP" ;; "CLOS" "ACLMOP"
  #+clisp "CLOS"
  #+cmu "CLOS-MOP" ;; "MOP"
  #+ecl "CLOS"
  #+gcl "PCL"
  #+lispworks "CLOS"
  #+(or clozure mcl) "CCL"
  #+sbcl "SB-MOP"
  #+scl "CLOS")

(defparameter *mop-known-standard-features*
  '(:accessor-method-initialized-with-function
    :accessor-method-initialized-with-lambda-list
    :accessor-method-initialized-with-slot-definition
    :accessor-method-initialized-with-specializers
    :accessor-method-slot-definition 
    :add-direct-method 
    :add-direct-subclass
    :add-method-calls-add-direct-method
    :add-method-calls-compute-discriminating-function 
    :add-method-calls-remove-method
    :add-method-updates-specializer-direct-generic-functions
    :add-method-updates-specializer-direct-methods
    :allocation-passed-to-direct-slot-definition-class
    :allocation-passed-to-effective-slot-definition-class
    :anonymous-classes
    :anonymous-generic-functions
    :built-in-class
    :class
    :class-default-initargs
    :class-direct-default-initargs
    :class-direct-slots 
    :class-direct-subclasses
    :class-direct-subclasses-returns-direct-subclasses
    :class-direct-superclasses
    :class-finalized-p 
    :class-initialization-calls-direct-slot-definition-class
    :class-initialization-calls-reader-method-class
    :class-initialization-calls-writer-method-class
    :class-initialized-with-direct-default-initargs 
    :class-initialized-with-direct-slots 
    :class-initialized-with-direct-superclasses 
    :class-initialized-with-documentation 
    :class-initialized-with-name 
    :class-precedence-list
    :class-prototype 
    :class-reinitialization-calls-add-direct-subclass
    :class-reinitialization-calls-ensure-class-using-class
    :class-reinitialization-calls-remove-direct-subclass
    :class-slots
    :classes-are-always-their-own-valid-superclasses
    :compute-applicable-methods-is-generic
    :compute-applicable-methods-using-classes
    :compute-class-precedence-list
    :compute-default-initargs
    :compute-effective-method
    :compute-effective-method-is-generic
    :compute-effective-slot-definition
    :compute-slots
    :compute-slots-requested-slot-order-honoured
    :default-reader-methods-are-standard-reader-methods
    :default-superclass-for-funcallable-standard-class-is-funcallable-standard-object
    :default-superclass-for-standard-class-is-standard-object
    :default-writer-methods-are-standard-writer-methods
    :defclass-calls-initialize-instance
    :defclass-calls-reinitialize-instance
    :defgeneric-calls-ensure-generic-function-using-class
    :defgeneric-calls-find-method-combination
    :defmethod-calls-add-method 
    :defmethod-calls-generic-function-method-class
    :defmethod-calls-initialize-instance
    :defmethod-calls-make-method-lambda
    :dependent-protocol-for-classes
    :dependent-protocol-for-generic-functions 
    :direct-slot-definition 
    :direct-slot-definition-class 
    :direct-slot-definition-initialized-with-allocation 
    :direct-slot-definition-initialized-with-documentation 
    :direct-slot-definition-initialized-with-initargs 
    :direct-slot-definition-initialized-with-initform 
    :direct-slot-definition-initialized-with-initfunction 
    :direct-slot-definition-initialized-with-name 
    :direct-slot-definition-initialized-with-readers 
    :direct-slot-definition-initialized-with-type 
    :direct-slot-definition-initialized-with-writers 
    :direct-superclasses-by-default-empty 
    :discriminating-functions-can-be-closures
    :discriminating-functions-can-be-funcalled
    :documentation-passed-to-direct-slot-definition-class
    :documentation-passed-to-effective-slot-definition-class
    :effective-slot-definition
    :effective-slot-definition-class 
    :effective-slot-definition-initialized-with-allocation 
    :effective-slot-definition-initialized-with-documentation 
    :effective-slot-definition-initialized-with-initargs 
    :effective-slot-definition-initialized-with-initform 
    :effective-slot-definition-initialized-with-initfunction 
    :effective-slot-definition-initialized-with-name 
    :effective-slot-definition-initialized-with-type 
    :ensure-class-using-class
    :ensure-generic-function-using-class 
    :eql-specializer
    :eql-specializer-object
    :eql-specializers-are-objects
    :extensible-allocation
    :extract-lambda-list
    :extract-specializer-names 
    :finalize-inheritance
    :finalize-inheritance-calls-compute-class-precedence-list
    :finalize-inheritance-calls-compute-default-initargs
    :finalize-inheritance-calls-compute-effective-slot-definition
    :finalize-inheritance-calls-compute-slots
    :finalize-inheritance-calls-effective-slot-definition-class
    :find-method-combination
    :find-method-is-generic
    :forward-referenced-class
    :forward-referenced-class-changed-by-change-class
    :funcallable-instance-functions-can-be-closures
    :funcallable-standard-class
    :funcallable-standard-object
    :funcallable-standard-instance-access 
    :function-invocation-calls-compute-applicable-methods 
    :function-invocation-calls-compute-applicable-methods-using-classes 
    :function-invocation-calls-compute-effective-method 
    :generic-function
    :generic-function-argument-precedence-order
    :generic-function-argument-precedence-order-returns-required-arguments
    :generic-function-declarations 
    :generic-function-initialized-with-argument-precedence-order
    :generic-function-initialized-with-declarations
    :generic-function-initialized-with-documentation
    :generic-function-initialized-with-lambda-list
    :generic-function-initialized-with-method-class
    :generic-function-initialized-with-method-combination
    :generic-function-initialized-with-name
    :generic-function-lambda-list
    :generic-function-method-class
    :generic-function-method-class-is-generic
    :generic-function-method-combination
    :generic-function-methods
    :generic-function-name
    :generic-functions-can-be-empty
    :initargs-passed-to-direct-slot-definition-class
    :initargs-passed-to-effective-slot-definition-class
    :initform-passed-to-direct-slot-definition-class
    :initform-passed-to-effective-slot-definition-class
    :initfunction-passed-to-direct-slot-definition-class
    :initfunction-passed-to-effective-slot-definition-class
    :initialize-instance-calls-compute-discriminating-function
    :initialize-lambda-list-initializes-argument-precedence-order
    :intern-eql-specializer
    :make-instance-calls-finalize-inheritance
    :make-method-lambda
    :metaobject
    :method
    :method-combination
    :method-function
    :method-functions-take-processed-parameters
    :method-generic-function
    :method-initialized-with-documentation
    :method-initialized-with-function
    :method-initialized-with-lambda-list
    :method-initialized-with-qualifiers
    :method-initialized-with-specializers
    :method-lambda-list
    :method-lambdas-are-processed
    :method-qualifiers
    :method-specializers
    :multiple-qualifiers
    :multiple-slot-options-passed-as-list-to-direct-slot-definition-class
    :name-passed-to-direct-slot-definition-class
    :name-passed-to-effective-slot-definition-class
    :reader-method-class
    :readers-passed-to-direct-slot-definition-class
    :reinitialize-instance-calls-compute-discriminating-function
    :reinitialize-instance-calls-finalize-inheritance
    :reinitialize-lambda-list-reinitializes-argument-precedence-order
    :remove-direct-method
    :remove-direct-subclass
    :remove-method-calls-compute-discriminating-function
    :remove-method-calls-remove-direct-method
    :remove-method-is-generic
    :set-funcallable-instance-function
    :setf-class-name
    :setf-class-name-calls-reinitialize-instance
    :setf-generic-function-name
    :setf-generic-function-name-calls-reinitialize-instance
    :setf-slot-value-calls-setf-slot-value-using-class
    :setf-slot-value-using-class
    :setf-slot-value-using-class-specialized-on-slot-definition
    :single-slot-options-passed-as-singletons-to-direct-slot-definition-class
    :slot-boundp-calls-slot-boundp-using-class
    :slot-boundp-using-class
    :slot-boundp-using-class-specialized-on-slot-definition
    :slot-definition
    :slot-definition-allocation
    :slot-definition-documentation
    :slot-definition-initargs
    :slot-definition-initform
    :slot-definition-initfunction
    :slot-definition-location
    :slot-definition-name
    :slot-definition-readers
    :slot-definition-type
    :slot-definition-writers
    :slot-makunbound-calls-slot-makunbound-using-class
    :slot-makunbound-using-class
    :slot-makunbound-using-class-specialized-on-slot-definition
    :slot-reader-calls-slot-value-using-class
    :slot-value-calls-slot-value-using-class
    :slot-value-using-class
    :slot-value-using-class-specialized-on-slot-definition
    :slot-writer-calls-slot-value-using-class
    :specializer 
    :specializer-direct-generic-functions
    :specializer-direct-methods
    :standard-accessor-method
    :standard-class
    :standard-class-and-funcallable-standard-class-are-compatible
    :standard-direct-slot-definition
    :standard-effective-slot-definition
    :standard-generic-function
    :standard-instance-access
    :standard-method
    :standard-object
    :standard-reader-method
    :standard-slot-definition
    :standard-writer-method
    :subclasses-of-built-in-class-do-not-inherit-exported-slots
    :subclasses-of-class-do-not-inherit-exported-slots
    :subclasses-of-direct-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-effective-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-eql-specializer-do-not-inherit-exported-slots
    :subclasses-of-forward-referenced-class-do-not-inherit-exported-slots
    :subclasses-of-funcallable-standard-class-do-not-inherit-exported-slots
    :subclasses-of-funcallable-standard-object-do-not-inherit-exported-slots
    :subclasses-of-generic-function-do-not-inherit-exported-slots
    :subclasses-of-metaobject-do-not-inherit-exported-slots
    :subclasses-of-method-do-not-inherit-exported-slots
    :subclasses-of-method-combination-do-not-inherit-exported-slots
    :subclasses-of-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-specializer-do-not-inherit-exported-slots
    :subclasses-of-standard-accessor-method-do-not-inherit-exported-slots
    :subclasses-of-standard-class-do-not-inherit-exported-slots
    :subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-standard-generic-function-do-not-inherit-exported-slots
    :subclasses-of-standard-method-do-not-inherit-exported-slots
    :subclasses-of-standard-object-do-not-inherit-exported-slots
    :subclasses-of-standard-reader-method-do-not-inherit-exported-slots
    :subclasses-of-standard-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-standard-writer-method-do-not-inherit-exported-slots
    :t-is-always-a-valid-superclass
    :type-passed-to-direct-slot-definition-class
    :type-passed-to-effective-slot-definition-class
    :validate-superclass
    :writer-method-class
    :writers-passed-to-direct-slot-definition-class))

(defparameter *mop-known-missing-features*
  '(:accessor-method-slot-definition
    :add-direct-method
    :add-method-updates-specializer-direct-methods
    :classes-are-always-their-own-valid-superclasses
    :compute-applicable-methods-is-generic
    :compute-effective-method
    :compute-effective-method-is-generic
    :default-reader-methods-are-standard-reader-methods
    :default-writer-methods-are-standard-writer-methods
    :defmethod-calls-initialize-instance
    :direct-slot-definition-initialized-with-type
    :extract-lambda-list
    :extract-specializer-names
    :find-method-is-generic
    :funcallable-instance-functions-can-be-closures
    :funcallable-standard-class
    :generic-function-argument-precedence-order-returns-required-arguments
    :generic-function-method-class-is-generic
    :generic-function-method-combination
    :initform-passed-to-direct-slot-definition-class
    :initform-passed-to-effective-slot-definition-class
    :method-initialized-with-documentation
    :method-initialized-with-lambda-list
    :method-initialized-with-qualifiers
    :method-initialized-with-specializers
    :reader-method-class
    :remove-direct-method
    :remove-method-is-generic
    :slot-definition-initform
    :slot-definition-initfunction
    :slot-definition-type
    :specializer-direct-methods
    :standard-accessor-method
    :standard-reader-method
    :standard-writer-method
    :type-passed-to-direct-slot-definition-class
    :validate-superclass
    :writer-method-class

    :accessor-method-initialized-with-function
    :accessor-method-initialized-with-lambda-list
    :accessor-method-initialized-with-slot-definition
    :accessor-method-initialized-with-specializers
    :add-method-calls-add-direct-method
    :add-method-calls-compute-discriminating-function
    :add-method-calls-remove-method
    :add-method-updates-specializer-direct-generic-functions
    :allocation-passed-to-effective-slot-definition-class
    :anonymous-classes
    :class-default-initargs
    :class-direct-default-initargs
    :class-initialization-calls-reader-method-class
    :class-initialization-calls-writer-method-class
    :class-initialized-with-direct-default-initargs
    :class-reinitialization-calls-remove-direct-subclass
    :compute-applicable-methods-using-classes
    :compute-default-initargs
    :compute-slots-requested-slot-order-honoured
    :default-superclass-for-funcallable-standard-class-is-funcallable-standard-object
    :defgeneric-calls-find-method-combination
    :defmethod-calls-generic-function-method-class
    :defmethod-calls-make-method-lambda
    :dependent-protocol-for-classes
    :dependent-protocol-for-generic-functions
    :direct-slot-definition
    :direct-superclasses-by-default-empty
    :discriminating-functions-can-be-closures
    :discriminating-functions-can-be-funcalled
    :documentation-passed-to-effective-slot-definition-class
    :effective-slot-definition
    :effective-slot-definition-initialized-with-allocation
    :effective-slot-definition-initialized-with-documentation
    :eql-specializer
    :eql-specializer-object
    :eql-specializers-are-objects
    :extensible-allocation
    :finalize-inheritance-calls-compute-default-initargs
    :find-method-combination
    :forward-referenced-class-changed-by-change-class
    :funcallable-standard-instance-access
    :funcallable-standard-object
    :function-invocation-calls-compute-applicable-methods
    :function-invocation-calls-compute-applicable-methods-using-classes
    :function-invocation-calls-compute-effective-method
    :generic-function-declarations
    :generic-function-initialized-with-declarations
    :generic-functions-can-be-empty
    :initialize-instance-calls-compute-discriminating-function
    :intern-eql-specializer
    :make-method-lambda
    :metaobject
    :method-functions-take-processed-parameters
    :method-initialized-with-function
    :method-lambdas-are-processed
    :multiple-qualifiers
    :multiple-slot-options-passed-as-list-to-direct-slot-definition-class
    :reinitialize-instance-calls-compute-discriminating-function
    :reinitialize-instance-calls-finalize-inheritance
    :reinitialize-lambda-list-reinitializes-argument-precedence-order
    :remove-method-calls-compute-discriminating-function
    :remove-method-calls-remove-direct-method
    :set-funcallable-instance-function
    :setf-class-name-calls-reinitialize-instance
    :setf-generic-function-name
    :setf-generic-function-name-calls-reinitialize-instance
    :setf-slot-value-using-class-specialized-on-slot-definition
    :slot-boundp-using-class-specialized-on-slot-definition
    :slot-definition
    :slot-definition-documentation
    :slot-makunbound-using-class-specialized-on-slot-definition
    :slot-reader-calls-slot-value-using-class
    :slot-value-using-class-specialized-on-slot-definition
    :slot-writer-calls-slot-value-using-class
    :specializer
    :specializer-direct-generic-functions
    :standard-class-and-funcallable-standard-class-are-compatible
    :standard-instance-access
    :standard-slot-definition
    :subclasses-of-built-in-class-do-not-inherit-exported-slots
    :subclasses-of-class-do-not-inherit-exported-slots
    :subclasses-of-direct-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-effective-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-eql-specializer-do-not-inherit-exported-slots
    :subclasses-of-forward-referenced-class-do-not-inherit-exported-slots
    :subclasses-of-funcallable-standard-class-do-not-inherit-exported-slots
    :subclasses-of-funcallable-standard-object-do-not-inherit-exported-slots
    :subclasses-of-generic-function-do-not-inherit-exported-slots
    :subclasses-of-method-combination-do-not-inherit-exported-slots
    :subclasses-of-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-specializer-do-not-inherit-exported-slots
    :subclasses-of-standard-accessor-method-do-not-inherit-exported-slots
    :subclasses-of-standard-class-do-not-inherit-exported-slots
    :subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-standard-generic-function-do-not-inherit-exported-slots
    :subclasses-of-standard-method-do-not-inherit-exported-slots
    :subclasses-of-standard-reader-method-do-not-inherit-exported-slots
    :subclasses-of-standard-slot-definition-do-not-inherit-exported-slots
    :subclasses-of-standard-writer-method-do-not-inherit-exported-slots
    :t-is-always-a-valid-superclass))

(defparameter *mop-known-extra-features*
  '(:method-initialized-with-simple-next-method-call
    :accessor-method-initialized-with-simple-next-method-call
    :effective-slot-definition-initialized-with-readers
    :effective-slot-definition-initialized-with-writers
    :readers-passed-to-effective-slot-definition-class
    :writers-passed-to-effective-slot-definition-class
    :location-passed-to-effective-slot-definition-class
    :effective-slot-definition-initialized-with-location
    :allocation-class-passed-to-direct-slot-definition-class
    :direct-slot-definition-initialized-with-allocation-class
    :accessor-method-initialized-with-allow-other-keys
    :accessor-method-initialized-with-definition-source
    :accessor-method-initialized-with-documentation
    :accessor-method-initialized-with-fast-function
    :accessor-method-initialized-with-generic-function
    :accessor-method-initialized-with-method-spec
    :accessor-method-initialized-with-name
    :accessor-method-initialized-with-plist
    :accessor-method-initialized-with-qualifiers
    :accessor-method-initialized-with-real-function
    :accessor-method-initialized-with-signature
    :accessor-method-initialized-with-slot-name
    :accessor-method-initialized-with-wants-next-method-p
    :add-method-calls-find-method
    :allocation-class-passed-to-effective-slot-definition-class
    :class-initialization-calls-compute-effective-slot-definition
    :class-initialization-calls-compute-slots
    :class-initialization-calls-effective-slot-definition-class
    :class-initialized-with-default-initargs 
    :class-initialized-with-definition-source 
    :class-initialized-with-fixed-slot-locations
    :class-initialized-with-generic-accessors
    :class-initialized-with-location
    :class-initialized-with-optimize-slot-access
    :class-initialized-with-safe-p
    :class-passed-to-direct-slot-definition-class
    :class-passed-to-effective-slot-definition-class
    :classes-must-be-named
    :compute-default-initargs-allegro
    :default-reader-passed-to-direct-slot-definition-class
    :default-writer-passed-to-direct-slot-definition-class
    :defclass-form-passed-to-direct-slot-definition-class
    :direct-slot-definition-initialized-with-class
    :direct-slot-definition-initialized-with-default-reader
    :direct-slot-definition-initialized-with-default-writer
    :direct-slot-definition-initialized-with-type-check-function
    :direct-superclasses-by-default-standard-metaobject
    :direct-superclasses-by-default-standard-symbol
    :effective-slot-definition-initialized-with-allocation-class
    :effective-slot-definition-initialized-with-class
    :effective-slot-definition-initialized-with-fixed-location
    :effective-slot-definition-initialized-with-flags
    :effective-slot-definition-initialized-with-inheritable-doc
    :effective-slot-definition-initialized-with-inheritable-initer
    :effective-slot-definition-initialized-with-type-check-function
    :eql-specializer-p
    :eql-specializers-are-conses
    :finalize-inheritance-calls-reader-method-class
    :finalize-inheritance-calls-writer-method-class
    :fixed-location-passed-to-effective-slot-definition-class
    :flags-passed-to-effective-slot-definition-class
    :function-invocation-calls-compute-discriminating-function
    :generic-function-initialized-with-declare
    :generic-function-initialized-with-definition-source
    :generic-function-initialized-with-generic-function-class
    :generic-function-initialized-with-initial-methods
    :generic-function-initialized-with-location
    :generic-function-initialized-with-methods
    :generic-functions-must-be-named
    :inheritable-doc-passed-to-effective-slot-definition-class
    :inheritable-initer-passed-to-effective-slot-definition-class
    :make-method-lambda-lispworks
    :method-functions-take-original-parameters
    :method-initialized-with-allow-other-keys
    :method-initialized-with-backpointer
    :method-initialized-with-definition-source
    :method-initialized-with-fast-function
    :method-initialized-with-generic-function
    :method-initialized-with-method-spec
    :method-initialized-with-name
    :method-initialized-with-plist
    :method-initialized-with-real-function
    :method-initialized-with-signature
    :method-initialized-with-wants-next-method-p
    :method-lambdas-are-unchanged
    :multiple-slot-options-passed-as-singletons-to-direct-slot-definition-class
    :setf-funcallable-standard-instance-access
    :setf-slot-value-using-class-specialized-on-symbol
    :setf-standard-instance-access
    :single-slot-options-passed-as-list-to-direct-slot-definition-class
    :slot-boundp-using-class-specialized-on-symbol
    :slot-makunbound-using-class-specialized-on-symbol
    :slot-value-using-class-specialized-on-symbol
    :slot-exists-p-calls-slot-exists-p-using-class
    :slot-exists-p-using-class
    :slot-exists-p-using-class-specialized-on-symbol
    :type-check-function-passed-to-direct-slot-definition-class
    :type-check-function-passed-to-effective-slot-definition-class))

(defparameter *mop-features* ())

(defparameter *mop-structure-leaks* ())

(defun check-features (&rest which-features)
  (let ((features (if (null which-features) 
                      '(:standard :missing :extra :leaks)
                    which-features)))
    (assert (null (set-difference features '(:standard :missing :extra :leaks)))
        (features) "I know only about :standard, :missing and :extra MOP features, and :leaks in its metaclass structure.")
    (when (or (member :standard features)
              (member :extra features))
      (let ((extra-features (set-difference 
                             *mop-features*
                             (union *mop-known-standard-features*
                                    *mop-known-extra-features*))))
        (assert (null extra-features)
            () "This MOP implementation has the feature~P ~(~{~:_~S~^, ~}~) that I don't know about."
          (list-length extra-features) extra-features)))
    (when (member :missing features)
      (let ((unknown-missing-features (set-difference
                                       (set-difference 
                                        *mop-known-standard-features* 
                                        *mop-features*)
                                       *mop-known-missing-features*)))
        (assert (null unknown-missing-features)
            () "This MOP implementation misses the feature~P ~(~{~:_~S~^, ~}~) whose potential absence I don't know about."
          (list-length unknown-missing-features) unknown-missing-features)))
    (values)))

(defun describe-mop-features (&rest which-features)
  (let ((features (if (null which-features) 
                    '(:standard :missing :extra :leaks)
                    which-features)))
    (assert (null (set-difference features '(:standard :missing :extra :leaks)))
        (features) "I know only about :standard, :missing and :extra MOP features, and :leaks in its metaclass structure.")
    (flet ((print-features (kind features)
             (if (null features)
               (format t (ecase kind
                           (:standard "~%This MOP supports no known standard features.~%")
                           (:missing "~%This MOP lacks no known standard features.~%")
                           (:extra "~%This MOP supports no known extra features.~%")
                           (:leaks "~%This MOP metaclass structure has no known leaks.~%")))
               (if (or (and (eq kind :standard)
                            (null (set-difference *mop-known-standard-features* features)))
                       (and (eq kind :missing)
                            (null (set-difference *mop-known-standard-features* features)))
                       (and (eq kind :extra)
                            (null (set-difference *mop-known-extra-features* features))))
                 (format t (ecase kind
                             (:standard "~%This MOP supports all known standard features.~%")
                             (:missing "~%This MOP lacks all known standard features.~%")
                             (:extra "~%This MOP supports all known extra features.~%")))
                 (format t (ecase kind
                             (:standard "~%This MOP supports the standard features ~S~%")
                             (:missing "~%This MOP lacks the standard features ~S~%")
                             (:extra "~%This MOP supports the extra features ~S~%")
                             (:leaks "~%This MOP metaclass structure has the leaks ~S~%"))
                         (sort (copy-list features) #'string-lessp :key #'symbol-name))))))
      (when (member :standard features)
        (print-features :standard (intersection *mop-features* *mop-known-standard-features*)))
      (when (member :missing features)
        (print-features :missing (set-difference *mop-known-standard-features* *mop-features*)))
      (when (member :extra features)
        (print-features :extra (intersection *mop-features* *mop-known-extra-features*)))
      (when (member :leaks features)
        (print-features :leaks *mop-structure-leaks*))
      (values))))

(defun report-changes (previous-features &optional raw-check)
  (let ((previous-features
         (if raw-check
           (loop for feature in previous-features collect (list (car feature)))
           previous-features)))
    (format t "The following features are now additionally missing: ~S~%"
            (set-difference
             (set-difference *mop-known-standard-features* *mop-features*)
             (mapcar #'car previous-features)))
    (format t "The following fixed features are now missing: ~S~%"
            (set-difference
             (set-difference *mop-known-standard-features* *mop-features*)
             (loop for feature in previous-features
                   unless (cadr feature)
                   collect (car feature))))
    (format t "The following features are now fixed: ~S~%"
            (intersection
             (loop for feature in previous-features
                   unless (cadr feature)
                   collect (car feature))
             *mop-features*))))

(defun find-external-symbol (name &optional (package *package*))
  (multiple-value-bind
      (sym status)
      (find-symbol name package)
    (when (eq status :external) sym)))

(defun fboundp* (sym)
  (etypecase sym
    (symbol (when sym (fboundp sym)))
    (cons (when (cadr sym) (fboundp sym)))))

(defun mop-function-p (name)
  (or (fboundp* (find-external-symbol
                 name *mop-package-name*))
      (fboundp* (find-external-symbol
                 name :common-lisp))))

(defun mop-setf-function-p (name)
  (or (fboundp* `(setf ,(find-external-symbol
                     name *mop-package-name*)))
      (fboundp* `(setf ,(find-external-symbol
                         name :common-lisp)))))

(defun find-class* (sym)
  (when sym (find-class sym)))

(defun mop-class-p (name)
  (find-class* (find-external-symbol
                name *mop-package-name*)))

(defun make-temp-package (name)
  (eval `(defpackage ,name
           (:use "COMMON-LISP" ,*mop-package-name* "MOP-FEATURE-TESTS")
           (:shadowing-import-from ,*mop-package-name*
            ,@(loop for sym being the external-symbols of :common-lisp
                    when (member (symbol-name sym)
                                 (package-shadowing-symbols *mop-package-name*)
                                 :test #'string=
                                 :key #'symbol-name)
                    collect (symbol-name sym))))))
                                 

(defmacro with-temporary-package ((name) &body body)
  (with-unique-names (temp-package)
    `(let ((,temp-package (make-temp-package ',name)))
       (unwind-protect
           (let ((*package* ,temp-package)) ,@body)
         (delete-package ,temp-package)))))

(defun acknowledge (feature)
  (print feature)
  (pushnew feature *mop-features*))

(defun acknowledge-function (name)
  (when (mop-function-p name)
    (acknowledge (intern name :keyword))))

(defun acknowledge-setf-function (name)
  (when (mop-setf-function-p name)
    (acknowledge (intern (concatenate 'string "SETF-" name)
                         :keyword))))

(defun report-leak (&rest symbols)
  (let ((report
         (intern
          (with-output-to-string (out)
            (loop for symbol in symbols
                  for firstp = t then nil do
                  (unless firstp
                    (princ "-" out))
                  (princ (symbol-name symbol) out)))
          :keyword)))
    (print report)
    (pushnew report *mop-structure-leaks*)))

(defparameter *mop-feature-test-path*
  (let ((truename (truename
                   (asdf:system-definition-pathname
                    (asdf:find-system :mop-feature-tests)))))
    (make-pathname :name nil :type nil
                   :directory (let ((pd (pathname-directory truename)))
                                (let ((last (car (last pd))))
                                  (if (eql (aref last 0) #\.)
                                    (butlast pd)
                                    pd)))
                   :defaults truename)))

(defun load-feature-test (which)
  (assert (null (find-package "TEMP")))
  (with-temporary-package ("TEMP")
    (load which :verbose t))
  t)

(defun run-feature-test (which)
  (when (load-feature-test
         (make-pathname
          :directory (append (pathname-directory *mop-feature-test-path*)
                             '("tests"))
          :name which 
          :type "lisp"))
    (check-features :standard :extra :leaks)
    t))

(defun run-feature-tests (&optional (*mop-package-name* *mop-package-name*) (breakp nil))
  (setf *mop-features* ())
  (setf *mop-structure-leaks* ())
  (when (every #'identity
               (loop for test in (directory
                                  (make-pathname
                                   :directory (append (pathname-directory *mop-feature-test-path*)
                                                      '("tests"))
                                   :name :wild
                                   :type "lisp"))
                     collect (prog1 (load-feature-test test)
                               (when breakp (break)))))
    (check-features)
    t))

(defun write-mop-features ()
  (let* ((filename (make-pathname
                    :directory (pathname-directory *mop-feature-test-path*)
                    :name "mop-features"
                    :type "lisp"))
         (initial-write-p (not (probe-file filename))))
    (with-open-file (out filename
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :create)
      (when initial-write-p
        (format out "(in-package :closer-mop)~%~%")
        (format out "(defparameter *mop-known-standard-features*~%")
        (format out "  '~S)~%~%" *mop-known-standard-features*)
        (format out "(defparameter *mop-known-missing-features*~%")
        (format out "  '~S)~%~%" *mop-known-missing-features*)
        (format out "(defparameter *mop-known-extra-features*~%")
        (format out "  '~S)~%~%" *mop-known-extra-features*))
      (format out
              #+abcl "#+abcl~%"
              #+allegro "#+allegro~%"
              #+clisp "#+clisp~%"
              #+cmu "#+cmu~%"
              #+ecl "#+ecl~%"
              #+gcl "#+gcl~%"
              #+lispworks "#+lispworks~%"
              #+mcl "#+mcl~%"
	      #+clozure "#+clozure~%"
              #+sbcl "#+sbcl~%"
              #+scl "#+scl~%")
      (format out "(progn~%")
      (format out "  (defparameter *mop-features*~%")
      (format out "    '~S)~%~%" *mop-features*)
      (format out "  (defparameter *mop-structure-leaks*~%")
      (format out "    '~S))~%~%" *mop-structure-leaks*))))
