(handler-case
    (progn
      (make-instance 'standard-class)
      (acknowledge :anonymous-classes))
  (error () (acknowledge :classes-must-be-named)))

(handler-case
    (progn
      (make-instance 'standard-generic-function)
      (acknowledge :anonymous-generic-functions))
  (error () (acknowledge :generic-functions-must-be-named)))
