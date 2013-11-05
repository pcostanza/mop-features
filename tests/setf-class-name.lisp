(defclass test-class (standard-class) ())

(defmethod validate-superclass
           ((class test-class)
            (superclass standard-class))
  t)

(defvar *reinitialize-action*)

(defmethod reinitialize-instance :before
  ((class test-class) &key name &allow-other-keys)
  (funcall *reinitialize-action* class name))

(defclass test-object () ()
  (:metaclass test-class))

(when (mop-setf-function-p "CLASS-NAME")
  (acknowledge :setf-class-name)

  (let ((*reinitialize-action*
         (lambda (class name)
           (when (and (eq class (find-class 'test-object))
                      (eq name 'test-object-1))
             (acknowledge :setf-class-name-calls-reinitialize-instance)))))
    (setf (class-name (find-class 'test-object)) 'test-object-1)))
