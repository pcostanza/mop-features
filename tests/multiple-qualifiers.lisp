(define-method-combination bla ()
  ((all-methods *))
  `(call-method ,(first all-methods)
                ,(rest all-methods)))

(defgeneric test (x)
  (:method-combination bla))

(handler-case
    (progn
      (eval '(defmethod test 1 2 3 (x)
               (* x x)))
      (when (eql 25 (test 5))
        (acknowledge :multiple-qualifiers)))
  (error ()))
