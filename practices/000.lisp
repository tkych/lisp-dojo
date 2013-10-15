;;;; Last modified: 2013-10-15 18:54:58 tkych

(define-practice
  ;; The identity number. It must be the same as file-name.
  ;; <non-negative-integer>
  :id       0

  ;; The name of the practice.
  ;; <symbol>
  :name     hello

  ;; Degrees of defficulty
  ;; <integer: 0 3>
  :level    0

  ;; Problem
  ;; <string>
  :problem "
 HELLO => greeting-string

   Make function HELLO.
   It takes no arguments, and returns \"Wellcome to the Lisp Dojo!\".

 Example:

   (hello) => \"Wellcome to the Lisp Dojo!\"
"

  ;; Hint for practice.
  ;; <string> or <null> (default is nil)
  :hint "
 * If practice is too hard, skip it.
 * Let's use REPL, fully.
"
  ;; solution for practice.
  ;; <string>
  :solutions "
 * (defun hello ()
     \"Wellcome to the Lisp Dojo!\")"

  ;; Reference for practice
  ;; You should announce where question, hint and sample-answers came from if it are quoted.
  ;; <string> or <null> (default is nil)
  :reference "
 * https://github.com/tkych/lisp-dojo"

  ;; Environment for testing
  ;; <list> (default is nil)
  ;; list of (special variables, functions and macros) definitions being used by test-fn.
  :test-env nil
  
  ;; Tests for checking the answer of the practice is correct or not.
  ;; <list> of eval-test
  ;; `=>?' means whether the evaled second form is equal to third value.
  ;; `<=>?' means whether the second form is equal to the thrid form as evaluation.
  :test ((=>? (hello) "Wellcome to the Lisp Dojo!"))
  )
