
(acknowledge-function "INTERN-EQL-SPECIALIZER")
(acknowledge-function "EQL-SPECIALIZER-P")
(acknowledge-function "EQL-SPECIALIZER-OBJECT")

(let* ((method (defmethod test ((x (eql 5)))
                 (print 'hi)))
       (specializer (car (method-specializers method))))
  (if (consp specializer)
      (acknowledge :eql-specializers-are-conses)
    (acknowledge :eql-specializers-are-objects)))
