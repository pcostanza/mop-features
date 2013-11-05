(defclass test1 ()
  ()
  (:metaclass standard-class))

(unless (class-finalized-p (find-class 'test1))
  (finalize-inheritance (find-class 'test1)))

(when (find-class 'funcallable-standard-class nil)
  (defclass test2 ()
    ()
    (:metaclass funcallable-standard-class))
  (unless (class-finalized-p (find-class 'test2))
    (finalize-inheritance (find-class 'test2))))

(when (subtypep 'test1 'standard-object)
  (acknowledge :default-superclass-for-standard-class-is-standard-object))

(when (and (find-class 'funcallable-standard-class nil)
           (find-class 'funcallable-standard-object nil)
           (subtypep 'test2 'funcallable-standard-object))
  (acknowledge :default-superclass-for-funcallable-standard-class-is-funcallable-standard-object))
