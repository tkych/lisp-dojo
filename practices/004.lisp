;;;; Last modified: 2013-10-12 10:54:07 tkych

(define-practice
  :id       004
  :name     last1
  :level    0
  :problem "
 LAST1 list => object

   Make function LAST1.
   It returns the last elememt of the `list'.

 Examples:

   (last1 '())          => NIL
   (last1 '(a b c d))   => D
   (last1 '(a b (c d))) => (C D)
"
  :hint
  nil
  :solutions "
 * (defun last1 (lst) (first (last lst)))"
  :reference "
 * On Lisp"
  :test-env
  nil
  :test
  ((=>? (last1 '())          NIL)
   (=>? (last1 '(a b c))     C)
   (=>? (last1 '(a b (c d))) (C D)))
  )
