;;;; Last modified: 2013-10-12 10:53:35 tkych

(define-practice
  :id       001
  :name     ensure-list
  :level    0
  :problem "
 ENSURE-LIST object => list

   Make function ENSURE-LIST.
   If `object' is a list, then returns `object' itself,
   otherwise return (`object').

 Examples:

   (ensure-list nil)      => NIL
   (ensure-list 'a)       => (A)
   (ensure-list '(a b c)) => (A B C)
"
  :hint nil
  :solutions "
 * (defun ensure-list (x) (if (listp x) x (list x)))"
  :reference
  nil
  :test-env
  nil
  :test
  ((=>? (ensure-list nil)      NIL)
   (=>? (ensure-list 'a)       (A))
   (=>? (ensure-list '(a b c)) (A B C)))
  )
