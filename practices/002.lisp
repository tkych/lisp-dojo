;;;; Last modified: 2013-10-12 10:53:47 tkych

(define-practice
  :id       002
  :name     singlep
  :level    0
  :problem "
  SINGLEP object => boolean

    Make function SINGLEP.
    If `object' is singleton list, return T, otherwise NIL.

  Examples:

    (singlep nil)      => NIL
    (singlep 'a)       => NIL
    (singlep '(a))     => T
    (singlep '(a b c)) => NIL
"
  :hint "
 If cdr of `object' is nil, then `object' has at most one element."
  :solutions "
 * (defun singlep (x)
     (and (consp x) (endp (rest x))))"
  :reference "
 * On Lisp"
  :test-env
  nil
  :test
  ((=>? (singlep nil)      NIL)
   (=>? (singlep 'a)       NIL)
   (=>? (singlep '(a))     T)
   (=>? (singlep '(a b c)) NIL))
  )
