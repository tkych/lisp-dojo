;;;; Last modified: 2013-10-15 15:26:58 tkych

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

   (ensure-list ())       => ()
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
  ((=>? (ensure-list ())       ())
   (=>? (ensure-list 'a)       (A))
   (=>? (ensure-list '(a b c)) (A B C)))
  )
