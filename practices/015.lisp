;;;; Last modified: 2013-10-12 22:19:54 tkych

(define-practice
  :id       015
  :name     remove-nth
  :level    0
  :problem "
 REMOVE-NTH n list => result-list

   Make function REMOVE-NTH.
   It returns list that does not contains the `n'th element.

 Examples:

   (remove-nth -1 '())      => NIL
   (remove-nth -1 '(0 1 2)) => (0 1 2)
   (remove-nth  0 '())      => NIL
   (remove-nth  1 '(0 1 2)) => (0 2)
   (remove-nth  3 '(0 1 2)) => (0 1 2)
   (remove-nth  3 '())      => NIL
"
  :hint
  nil
  :solutions "
 * (defun remove-nth (n lst)
     (labels ((rec (count acc remain)
                (cond ((zerop count) (revappend acc (rest remain)))
                      ((null remain) lst)
                      (t (rec (1- count)
                              (cons (first remain) acc)
                              (rest remain))))))
       (rec n '() lst)))

 * (defun remove-nth (n lst)
     (if (minusp n)
         lst
         (let ((len (length lst)))
           (append (subseq lst 0 (min n len))
                   (subseq lst (min len (1+ n)))))))"
  :reference
  nil
  :test-env
  nil
  :test
  ((=>? (remove-nth -1 '())      NIL)
   (=>? (remove-nth -1 '(0 1 2)) (0 1 2))
   (=>? (remove-nth  0 '())      NIL)
   (=>? (remove-nth  1 '(0 1 2)) (0 2))
   (=>? (remove-nth  3 '(0 1 2)) (0 1 2))
   (=>? (remove-nth  3 '())      NIL))
  )
