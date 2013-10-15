;;;; Last modified: 2013-10-15 18:59:02 tkych

(define-practice
  :id       016
  :name     remove-every-nth
  :level    1
  :problem "
 REMOVE-EVERY-NTH n list => result-list

   Make function REMOVE-EVERY-NTH.
   It returns list that does not contains every the `n'th element.
   If `n' is not a positive integer, REMOVE-EVERY-NTH must signal an error.

 Examples:

   (remove-every-nth 1 '(0 1 2 3 4 5 6)) => (0 2 4 6)
   (remove-every-nth 2 '(0 1 2 3 4 5 6)) => (0 1 3 4 6)
   (remove-every-nth 3 '(0 1 2 3 4 5 6)) => (0 1 2 4 5 6)
   (remove-every-nth 7 '(0 1 2 3 4 5 6)) => (0 1 2 3 4 5 6)
  
   (remove-every-nth  3 '(0 1 2)) => (0 1 2)
   (remove-every-nth  3 '())      => ()
  
   (remove-every-nth -1 '())      => ERROR!
   (remove-every-nth -1 '(0 1 2)) => ERROR!
   (remove-every-nth  0 '())      => ERROR!
   (remove-every-nth  0 '(0 1 2)) => ERROR!
"
  :hint
  nil
  :solutions "
 * (defun remove-every-nth (n lst)
     (if (<= n 0)
         (error \"~S is not a positive integer.\" n)
         (let ((result '())
               (i 0))
           (dolist (x lst)
             (cond ((= n i) (setf i 0))
                   (t (push x result)
                      (incf i))))
           (nreverse result))))


 * (defun remove-every-nth (n lst)
     (if (<= n 0)
         (error \"~S is not a positive integer.\" n)
         (labels ((rec (count acc remain)
                    (cond ((null remain) (nreverse acc))
                          ((zerop count) (nreconc acc
                                                  (rec n '() (rest remain))))
                          (t (rec (1- count)
                                  (cons (first remain) acc)
                                  (rest remain))))))
           (rec n '() lst))))"
  :reference
  nil
  :test-env
  nil
  :test
  ((=>? (remove-every-nth 1 '(0 1 2 3 4 5 6)) (0 2 4 6))
   (=>? (remove-every-nth 2 '(0 1 2 3 4 5 6)) (0 1 3 4 6))
   (=>? (remove-every-nth 3 '(0 1 2 3 4 5 6)) (0 1 2 4 5 6))
   (=>? (remove-every-nth 7 '(0 1 2 3 4 5 6)) (0 1 2 3 4 5 6))
   
   (=>? (remove-every-nth  3 '(0 1 2)) (0 1 2))
   (=>? (remove-every-nth  3 '())      ())
   
   (=>error? (remove-every-nth -1 '()))
   (=>error? (remove-every-nth -1 '(0 1 2)))
   (=>error? (remove-every-nth  0 '()))
   (=>error? (remove-every-nth  0 '(0 1 2))))
  )
