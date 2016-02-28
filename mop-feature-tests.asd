(asdf:defsystem #:mop-feature-tests
  :name "MOP Feature Tests"
  :description "This package provides a way to check what CLOS MOP features a Common Lisp implementation supports."
  :author "Pascal Costanza"
  :version "1.0.0"
  :licence "MIT-style license"
  :depends-on (#-lispworks #:lw-compat)
  :components ((:file "mop-features-packages")
               (:file "mop-feature-tests"
                :depends-on ("mop-features-packages"))))
