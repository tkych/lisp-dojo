;;;; Last modified: 2013-10-12 22:37:41 tkych

(define-practice
  :id       018
  :name     insert-every-nth
  :level    1
  :problem "
 INSERT-EVERY-NTH item n list => result-list

   Make function INSERT-EVERY-NTH.
   It returns list that contains `item' as every `n'th element.

 Examples:

   (insert-every-nth 'a  1 '(0 1 2 3)) => (0 A 1 A 2 A 3 A)
   (insert-every-nth 'a  2 '(0 1 2 3)) => (0 1 A 2 3 A)
   (insert-every-nth 'a 10 '(0 1 2 3)) => (0 1 2 3)
   (insert-every-nth 'a  3 '())        => NIL
   (insert-every-nth 'a -1 '())        => ERROR!
   (insert-every-nth 'a -1 '(0 1 2))   => ERROR!
   (insert-every-nth 'a  0 '())        => ERROR!
   (insert-every-nth 'a  0 '(0 1 2))   => ERROR!"
  :hint
  nil
  :solutions "
 * (defun insert-every-nth (item n lst)
     (unless (plusp n)
       (error \"N must be a plus integer.\"))
     (labels ((rec (count acc remain)
                (cond ((zerop count) (revappend acc
                                                (cons item
                                                      (rec n '() remain))))
                      ((null remain) (nreverse acc))
                      (t (rec (1- count)
                              (cons (first remain) acc)
                              (rest remain))))))
       (rec n '() lst)))"
  :reference
  nil
  :test-env
  nil
  :test
  ((=>? (insert-every-nth 'a  1 '(0 1 2 3)) (0 A 1 A 2 A 3 A))
   (=>? (insert-every-nth 'a  2 '(0 1 2 3)) (0 1 A 2 3 A))
   (=>? (insert-every-nth 'a 10 '(0 1 2 3)) (0 1 2 3))
   (=>? (insert-every-nth 'a  3 '())        NIL)
   (=>error? (insert-every-nth 'a -1 '()))
   (=>error? (insert-every-nth 'a -1 '(0 1 2)))
   (=>error? (insert-every-nth 'a  0 '()))
   (=>error? (insert-every-nth 'a  0 '(0 1 2))))
  )
