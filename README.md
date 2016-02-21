# MOP Feature Tests
This package provides a way to check what CLOS MOP features a Common Lisp implementation supports.

Currently, the following Common Lisp implementations are supported:
	•	Allegro Common Lisp 10.0 Express Edition
	•	Armed Bear Common Lisp 1.3.3
	•	CLisp 2.49
	•	Clozure Common Lisp 1.11
	•	CMU Common Lisp 21a
	•	Embeddable Common Lisp 16.0.0
	•	LispWorks 6.1.1 Personal Edition
	•	LispWorks 7.0.0 Hobbyist Edition
	•	Steel Bank Common Lisp 1.3.2

The following implementations were supported in the past:
	•	Allegro Common Lisp 7.0, 8.0 - 8.2 Enterprise Editions
	•	Allegro Common Lisp 9.0 Express Edition
	•	Armed Bear Common Lisp 1.1.1, 1.2.1, 1.3.0, 1.3.1, 1.3.2
	•	CLisp from 2.35 onward
	•	Clozure Common Lisp 1.2 - 1.10
	•	CMU Common Lisp 19c-f, 20a-f
	•	Embeddable Common Lisp 9.12.3, 10.3.1, 10.4.1, 11.1.1, 12.2.1, 12.12.1, 15.2.21, 15.3.7
	•	LispWorks 4.3 & 4.4, Personal and Professional Editions
	•	LispWorks 5.0.1, 5.0.2, 5.1.0 - 5.1.2 Personal and Professional Editions
	•	LispWorks 6.0, 6.0.1 Enterprise Editions
	•	LispWorks 6.1, 6.1.1, Professional Editions
	•	Macintosh Common Lisp 5.1, 5.2.1
	•	OpenMCL 1.0
	•	Scieneer Common Lisp 1.3.9
	•	Steel Bank Common Lisp from 0.9.16 onward (except version 1.0.0)

The respective code conditionalizations are still in the source files, so there is a good chance that they still work, especially for current or newer versions. However, there is no guarantee that this is the case, and active work for these implementations is currently on hold.

Highlights of version 1.0.0:
	•	New version number based on semantic versioning.
	•	Since version 0.5, support for Allegro Common Lisp 8.2 & 9.0, and ABCL has been added.

Highlights of version 0.5:
	•	Modifications for Clozure Common Lisp.
	•	Added support for Scenieer Common Lisp.
	•	Improved support for Embeddable Common Lisp.
	•	Resurrected support for Macintosh Common Lisp (now RMCL).
	•	Simplified conditionalizations for Clozure Common Lisp, and removed mentions of OpenMCL (which was just the old name for Clozure Common Lisp).
	•	Added mode for reporting changes against native MOP features.
	•	Added another test whether funcallable instances can be closures.

Highlights of version 0.45:
	•	Added new recognized standard feature :generic-function-argument-precedence-order-returns-required-arguments.

Highlights of version 0.44:
	•	Added new tests for standard metaobject classes.
	•	Simplified output for feature reports.
	•	Added a report function for quick comparison between two versions of a given CL implementation.
	•	Significantly simplified the test for extensible allocations.

Highlights of version 0.43:
	•	Added a test for dependencies between lambda-list and argument-precedence-order in initialization and reinitialization of generic functions.
	•	Added more detailed checks for metaobject readers.
	•	Added a test for slot inheritance in subclasses of specified metaobject classes.
	•	Fixed the test whether reinitialization of class metaobjects calls FINALIZE-INHERITANCE on those class metaobjects again. Unfortunately, some CL implementations do not pass the fixed test anymore.

Highlights of version 0.4:
	•	Added a test for checking whether the slot order requested by a primary method for COMPUTE-SLOTS is honored by a MOP. (Thanks to Christophe Rhodes for the suggestion.)
	•	Added a test for checking whether the object returend by COMPUTE-DISCRIMINATING-FUNCTION can be funcalled and whether the second parameter to SET-FUNCALLABLE-INSTANCE-FUNCTION can be a 'real' closure.
	•	Added a test for checking whether one can use one's own :ALLOCATION kinds.
	•	Added a test for checking whether a generic function without any methods defined can still be called.
	•	Added a test for checking whether a DEFMETHOD form can have multiple qualifiers.
	•	Added more fine-grained tests for checking SLOT-XXX-USING-CLASS functions.

The simplest way to use MOP Feature Tests is to load it with asdf, use the :mop-feature-tests package and execute the functions run-feature-tests and describe-mop-features without parameters.

You can also select to test single features by executing run-feature-test and pass the name of a feature test as a string to it. The tests are stored in the "tests" folder, each .lisp file therein represents one ore more feature tests.

Make sure that \*mop-feature-test-path\* points to the right folder. After execution of run-feature-tests, the variables \*mop-features\* and \*mop-structure-leaks\* describe the feature set of your MOP implementation. \*mop-features\* is a subset of (union \*mop-known-standard-features\* \*mop-known-extra-features\*). \*mop-known-standard-features\* are the MOP features as specified in AMOP, whereas \*mop-known-extra-features\* are both additional features not specified there, or features that are specified there but deviate from that specification in important ways. \*mop-known-missing-features\* is a list of all the features that are not supported in some of the supported Common Lisp implementations.

\*mop-structure-leaks\* is a subset of \*mop-known-structure-leaks\* - these are deviations from the metaobject class hierarchy as specified in AMOP. There is no \*mop-known-structure-adherences\*, or some such, because that list would be too long. (There will probably also be no way to circumvent these structure leaks.)

The other exported symbols from :mop-feature-tests are mostly utility functions to support implementing feature tests.

Please check the release notes for details about changes to previous versions.

Disclaimer: Don't publish any findings about existing MOP implementations based on the software offered here with the implicit suggestion that they are facts. It is very likely that the code includes bugs and misinterpretations of the AMOP specification. You have been warned!
