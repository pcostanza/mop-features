(in-package :cl-user)

(defpackage #:mop-feature-tests
  (:use #:common-lisp #:lispworks)
  (:export 
   #:acknowledge #:acknowledge-function #:acknowledge-setf-function
   #:report-leak #:run-feature-test #:run-feature-tests
   #:check-features #:describe-mop-features
   #:*mop-package-name*
   #:*mop-known-standard-features* #:*mop-known-extra-features* 
   #:*mop-known-missing-features* #:*mop-known-structure-leaks*
   #:*mop-features* #:*mop-structure-leaks*
   #:mop-function-p #:mop-setf-function-p #:mop-class-p
   #:report-changes
   #:write-mop-features))
