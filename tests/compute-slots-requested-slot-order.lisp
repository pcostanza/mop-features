(defclass test-class1 (standard-class) ())

#-(or clozure mcl)
(defclass test-class2 (funcallable-standard-class) ())

(defmethod validate-superclass
           ((class test-class1)
            (superclass standard-class))
  t)

#-(or clozure mcl)
(defmethod validate-superclass
           ((class test-class2)
            (superclass standard-class))
  t)

#-(or clozure mcl)
(defmethod validate-superclass
           ((class test-class2)
            (superclass funcallable-standard-class))
  t)

(defmethod compute-slots ((class test-class1))
  (let ((slots (call-next-method)))
    (sort (copy-list slots)
          #'string<
          :key (lambda (slot)
                 (symbol-name (slot-definition-name slot))))))

#-(or clozure mcl)
(defmethod compute-slots ((class test-class2))
  (let ((slots (call-next-method)))
    (sort (copy-list slots)
          #'string>
          :key (lambda (slot)
                 (symbol-name (slot-definition-name slot))))))

(defclass test-object1 ()
  (b a d e c)
  (:metaclass test-class1))

#+allegro (finalize-inheritance (find-class 'standard-object))
(unless (class-finalized-p (find-class 'test-object1))
  (finalize-inheritance (find-class 'test-object1)))

#-(or clozure mcl)
(defclass test-object2 ()
  (b a d e c)
  (:metaclass test-class2))

#+allegro (finalize-inheritance (find-class 'funcallable-standard-class))
#-(or clozure mcl)
(unless (class-finalized-p (find-class 'test-object2))
  (finalize-inheritance (find-class 'test-object2)))

(when (and (equal (mapcar #'slot-definition-location
                          (sort (copy-list (class-slots (find-class 'test-object1)))
                                #'string<
                                :key (lambda (slot)
                                       (symbol-name (slot-definition-name slot)))))
                  '(0 1 2 3 4))
           #-(or clozure mcl)
           (equal (mapcar #'slot-definition-location
                          (sort (copy-list (class-slots (find-class 'test-object2)))
                                #'string>
                                :key (lambda (slot)
                                       (symbol-name (slot-definition-name slot)))))
                  '(0 1 2 3 4)))
  (acknowledge :compute-slots-requested-slot-order-honoured))

