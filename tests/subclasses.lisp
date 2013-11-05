(defparameter *specified-classes*
  '(built-in-class
    class
    #-(or clozure mcl) direct-slot-definition #+(or clozure mcl) ccl::direct-slot-definition
    #-(or clozure mcl) effective-slot-definition #+(or clozure mcl) ccl::effective-slot-definition
    #-(or clozure mcl) eql-specializer #+(or clozure mcl) ccl::eql-specializer
    forward-referenced-class
    funcallable-standard-class
    funcallable-standard-object
    generic-function
    metaobject
    method
    method-combination
    #-(or clozure mcl) slot-definition #+(or clozure mcl) ccl::slot-definition
    specializer
    standard-accessor-method
    standard-class
    standard-direct-slot-definition
    standard-effective-slot-definition
    standard-generic-function
    standard-method
    standard-object
    standard-reader-method
    #-(or clozure mcl) standard-slot-definition #+(or clozure mcl) ccl::standard-slot-definition
    standard-writer-method))

(defun acknowledgement (class-name)
  (intern (concatenate 'string "SUBCLASSES-OF-" (symbol-name class-name)
                       "-DO-NOT-INHERIT-EXPORTED-SLOTS")
          :keyword))

#|
(defun collect-slot-names (class)
  (loop with classes-to-check = (list class)
        with checked-classes = '()
        with collected-slot-names = '()
        for current-class = (pop classes-to-check)
        unless (member current-class checked-classes) do
        (loop for slot in (class-direct-slots current-class)
              do (pushnew (slot-definition-name slot) collected-slot-names))
        (loop for direct-superclass in (class-direct-superclasses current-class)
              do (push direct-superclass classes-to-check))
        while classes-to-check
        finally (return collected-slot-names)))
|#

(loop for class-name in *specified-classes*
      for class = (find-class class-name nil)
      for subclass-name = (gensym)
      when class do
      (eval `(defclass ,subclass-name (,class-name)
               ()
               (:metaclass ,(class-name (class-of class)))))
      (unless (class-finalized-p (find-class subclass-name))
        (finalize-inheritance (find-class subclass-name)))
      end
      when (or (null class)
               (loop for slot in (class-slots (find-class subclass-name))
                     for slot-name = (slot-definition-name slot)
                     always (loop for package in (mapcar #'find-package `("CL" "CL-USER" "KEYWORD"
                                                                               ,*mop-package-name*))
                                  never (multiple-value-bind
                                            (symbol status)
                                            (find-symbol (symbol-name slot-name) package)
                                          (and (eq symbol slot-name)
                                               (or (eq status :external)
                                                   (eq package (find-package "COMMON-LISP-USER"))))))))
      do (acknowledge (acknowledgement class-name)))
