;;;; Last modified: 2013-10-15 18:59:15 tkych

(define-practice
  :id       017
  :name     insert-nth
  :level    0
  :problem "
 INSERT-NTH item n list => result-list

   Make function INSERT-NTH.
   It returns list that contains `item' as `n'th element.

 Examples:

   (insert-nth 'a  0 '(0 1 2 3)) => (A 0 1 2 3)
   (insert-nth 'a  1 '(0 1 2 3)) => (0 A 1 2 3)
   (insert-nth 'a 10 '(0 1 2 3)) => (0 1 2 3)
   (insert-nth 'a -1 '(0 1 2 3)) => (0 1 2 3)
   (insert-nth 'a  1 '())        => ()
   (insert-nth 'a  0 '())        => (A)
   (insert-nth 'a -1 '())        => ()
"
  :hint
  nil
  :solutions "
 * (defun insert-nth (item n lst)
     (labels ((rec (count acc remain)
                (cond ((zerop count) (revappend acc
                                                (cons item remain)))
                      ((null remain) lst)
                      (t (rec (1- count)
                              (cons (first remain) acc)
                              (rest remain))))))
       (rec n '() lst)))
"
  :reference
  nil
  :test-env
  nil
  :test
  ((=>? (insert-nth 'a  0 '(0 1 2 3)) (A 0 1 2 3))
   (=>? (insert-nth 'a  1 '(0 1 2 3)) (0 A 1 2 3))
   (=>? (insert-nth 'a 10 '(0 1 2 3)) (0 1 2 3))
   (=>? (insert-nth 'a -1 '(0 1 2 3)) (0 1 2 3))
   (=>? (insert-nth 'a  1 '())        ())
   (=>? (insert-nth 'a  0 '())        (A))
   (=>? (insert-nth 'a -1 '())        ()))
  )
