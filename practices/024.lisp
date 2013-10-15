;;;; Last modified: 2013-10-15 19:01:08 tkych

(define-practice
  :id       024
  :name     rotate
  :level    1
  :problem "
 ROTATE n list => result-list

   Make function ROTATE.
   It rotates a list N places to the left.

 Examples:

   (rotate  3 '())                => ()
   (rotate  3 '(a b c d e f g h)) => (D E F G H A B C)
   (rotate -2 '(a b c d e f g h)) => (G H A B C D E F)
"
  :hint
  nil
  :solutions "
 * (defun rotate (n lst)
     (when lst
       (let ((m (mod n (length lst))))
         (append (nthcdr m lst) (subseq lst 0 m)))))"
  :reference
  nil
  :test-env
  nil
  :test
  ((=>? (rotate  3 '(0 1 2 3 4 5 6)) (3 4 5 6 0 1 2))
   (=>? (rotate  0 '(0 1 2 3 4 5 6)) (0 1 2 3 4 5 6))
   (=>? (rotate -2 '(0 1 2 3 4 5 6)) (5 6 0 1 2 3 4))
   (=>? (rotate  3 '())              NIL)
   (=>? (rotate  0 '())              NIL)
   (=>? (rotate -2 '())              NIL))
  )
