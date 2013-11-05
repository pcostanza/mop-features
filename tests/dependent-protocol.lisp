#-(and scl (not closer-mop))
(progn
  (defclass updater () ())

  (defparameter *recorded-actions* (make-hash-table))

  (defmethod update-dependent ((dependee standard-generic-function) (updater updater) &rest args)
    (case (first args)
      (add-method    (print 'add-method)
                     (push (second args)
                           (gethash 'add-method *recorded-actions*)))
      (remove-method (print 'remove-method)
                     (push (second args)
                           (gethash 'remove-method *recorded-actions*)))
      (otherwise     (print 'reinit)
                     (push dependee
                           (gethash 'reinitialize *recorded-actions*)))))

  (defmethod update-dependent ((dependee standard-class) (updater updater) &rest args)
    (case (first args)
      (add-method    (push (second args)
                           (gethash 'add-method *recorded-actions*)))
      (remove-method (push (second args)
                           (gethash 'remove-method *recorded-actions*)))
      (otherwise     (push dependee
                           (gethash 'reinitialize *recorded-actions*)))))

  (defclass test-class ()
    ((name :accessor name))
    (:metaclass standard-class))

  (add-dependent (find-class 'test-class) (make-instance 'updater))

  (handler-bind ((warning #'muffle-warning))
    (reinitialize-instance (find-class 'test-class)))

  (when (loop for reinitialized-dependee in (gethash 'reinitialize *recorded-actions*)
              thereis (eq reinitialized-dependee (find-class 'test-class)))
    (acknowledge :dependent-protocol-for-classes))

  (clrhash *recorded-actions*)

  (defgeneric test-function ()
    (:generic-function-class standard-generic-function))

  (add-dependent #'test-function (make-instance 'updater))

  (defparameter *the-method*
    (make-instance 'standard-method
                   :qualifiers '()
                   :lambda-list '()
                   :specializers '()
                   :function 
                   #+(or clozure mcl) (lambda () nil)
                   #-(or clozure mcl) (constantly nil)))

  (add-method #'test-function *the-method*)

  (remove-method #'test-function *the-method*)

  (reinitialize-instance #'test-function)

  (when (and (loop for added-method in (gethash 'add-method *recorded-actions*)
                   thereis (eq added-method *the-method*))
             (loop for removed-method in (gethash 'remove-method *recorded-actions*)
                   thereis (eq removed-method *the-method*))
             (loop for reinitialized-dependee in (gethash 'reinitialize *recorded-actions*)
                   thereis (eq reinitialized-dependee #'test-function)))
    (acknowledge :dependent-protocol-for-generic-functions)))

