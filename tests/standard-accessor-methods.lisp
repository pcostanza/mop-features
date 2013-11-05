(defclass test ()
  ((slot :reader r :writer w :accessor a)))

#|
(unless (class-finalized-p (find-class 'test))
  (finalize-inheritance (find-class 'test)))
|#

(let ((slotd (find 'slot (class-direct-slots (find-class 'test))
                   :key #'slot-definition-name)))
  (let ((rmethod (find-method #'r '() (list (find-class 'test)) nil))
        (amethod (find-method #'a '() (list (find-class 'test)) nil)))
    (when (and rmethod (ignore-errors (typep rmethod 'standard-reader-method))
               amethod (ignore-errors (typep amethod 'standard-reader-method)))
      (acknowledge :default-reader-methods-are-standard-reader-methods)))
  (let ((wmethod (find-method #'w '() (list (find-class 't) (find-class 'test)) nil))
        (amethod (find-method #'(setf a) '() (list (find-class 't) (find-class 'test)) nil)))
    (when (and wmethod (ignore-errors (typep wmethod 'standard-writer-method))
               amethod (ignore-errors (typep amethod 'standard-writer-method)))
      (acknowledge :default-writer-methods-are-standard-writer-methods))))
