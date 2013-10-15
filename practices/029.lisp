;;;; Last modified: 2013-10-15 17:29:31 tkych

(define-practice
  :id       029
  :name     drop
  :level    0
  :problem "
 DROP n list => result-list

   Make function DROP.


 Examples:

   (drop 0 '(0 1 2))  => (0 1 2)
   (drop 1 '(0 1 2))  => (1 2)
   (drop 2 '(0 1 2))  => (2)
   (drop 3 '(0 1 2))  => ()
   (drop 4 '(0 1 2))  => ()
   (drop 4 '())       => ()
   (drop -1 '(0 1 2)) => ERROR!
" 
  :hint
  nil
  :solutions "
 * (defun drop (n lst)
     (check-type n (integer 0 *))
     (nthcdr n lst))

 * (defun drop (n lst)
     (check-type n (integer 0 *))
     (subseq lst (min n (length lst))))

 * (defun drop (n lst)
     (check-type n (integer 0 *))
     (loop for i from 0
           for x in lst
           when (<= n i)
             collect x))"
  :reference
  nil
  :test-env
  nil
  :test
  ((=>? (drop 0 '(0 1 2)) (0 1 2))
   (=>? (drop 1 '(0 1 2)) (1 2))
   (=>? (drop 2 '(0 1 2)) (2))
   (=>? (drop 3 '(0 1 2)) ())
   (=>? (drop 4 '(0 1 2)) ())
   (=>? (drop 1 '()) ())
   (=>error? (drop -1 '(0 1 2))))
  )
