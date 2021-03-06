;;;; Last modified: 2013-10-15 18:55:51 tkych

(define-practice
  :id       014
  :name     random-nth
  :level    0
  :problem "
 RANDOM-NTH list => object

   Make function RANDOM-NTH.
   It returns a one of a element in the `list', randomly.

 Examples:

   (random-nth '(0 1 2 3)) => 0 (or 1 or 2 or 3, randomly)
   (random-nth '(42))      => 42
   (random-nth '(42 42))   => 42
   (random-nth '())        => ERROR!
"
  :hint
  nil
  :solutions "
 * (defun random-nth (lst)
     (nth (random (length lst)) lst))"
  :reference
  nil
  :test-env
  ((defparameter rs0 (make-random-state t))
   (defparameter rs1 (make-random-state rs0)))
  :test
  ((=>error? (random-nth '()))
   (=>? (random-nth '(42)) 42)
   (=>? (random-nth '(42 42 42 42 42)) 42)
   (<=>? (let ((*random-state* (make-random-state rs0)))
           (loop repeat 10
                 collect (random-nth '(0 1 2 3 4 5))))
         (flet ((%random-nth (lst)
                  (nth (random (length lst) rs1) lst)))
           (loop repeat 10
                 collect (%random-nth '(0 1 2 3 4 5))))))
  )

