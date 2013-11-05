(defparameter *inheritance-structure*
  '((standard-object t)
    (funcallable-standard-object standard-object function)
    (metaobject standard-object)
    (generic-function metaobject funcallable-standard-object)
    (standard-generic-function generic-function)
    (method metaobject)
    (standard-method method)
    (standard-accessor-method standard-method)
    (standard-reader-method standard-accessor-method)
    (standard-writer-method standard-accessor-method)
    (method-combination metaobject)
    (slot-definition metaobject)
    (direct-slot-definition slot-definition)
    (effective-slot-definition slot-definition)
    (standard-slot-definition slot-definition)
    (standard-direct-slot-definition standard-slot-definition direct-slot-definition)
    (standard-effective-slot-definition standard-slot-definition effective-slot-definition)
    (specializer metaobject)
    (eql-specializer specializer)
    (class specializer)
    (built-in-class class)
    (forward-referenced-class class)
    (standard-class class)
    (funcallable-standard-class class)))

(defun ensure-finalized (class)
  (unless (or (null class)
              (class-finalized-p class))
    (finalize-inheritance class))
  class)

(loop for cpl in *inheritance-structure*
      do (let* ((class-name (car cpl))
                (class (ensure-finalized (find-class class-name nil))))

           (when (not (null class))
             (acknowledge (intern (symbol-name class-name) :keyword))

             (case class-name
               ((t) 
                (unless (typep class 'built-in-class)
                  (report-leak class-name :not-instance-of 'built-in-class)))

               ((generic-function standard-generic-function)
                (unless (typep class 'funcallable-standard-class)
                  (report-leak class-name :not-instance-of 'funcallable-standard-class)))
              
               (t (unless (typep class 'standard-class)
                    (report-leak class-name :not-instance-of 'standard-class))))

           (loop with rest-cpl = (class-precedence-list class)
                 for superclass-name in (cdr cpl)
                 for superclass = (ensure-finalized (find-class superclass-name nil))
                 do (cond ((null superclass)
                           (report-leak :cpl-for class-name
                                        :cannot-contain superclass-name))

                          ((member superclass rest-cpl)
                           (setf rest-cpl (member superclass rest-cpl)))

                          ((member superclass (class-precedence-list class))
                           (report-leak :cpl-for class-name :in-wrong-order))

                          (t (report-leak :cpl-for class-name
                                          :does-not-contain superclass-name)))))))
