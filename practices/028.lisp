;;;; Last modified: 2013-10-15 17:29:19 tkych

(define-practice
  :id       028
  :name     take
  :level    0
  :problem "
 TAKE n list => result-list

   Make function TAKE.


 Examples:

   (take 0 '(0 1 2)) => ()
   (take 1 '(0 1 2)) => (0)
   (take 2 '(0 1 2)) => (0 1)
   (take 3 '(0 1 2)) => (0 1 2)
   (take 4 '(0 1 2)) => (0 1 2)
   (take -1 '(0 1))  => ERROR!
"
  :hint
  nil
  :solutions "
 * (defun take (n lst)
     (check-type n (integer 0 *))
     (loop repeat n
           for x in lst
           collect x))

 * (defun take (n lst)
     (check-type n (integer 0 *))
     (subseq lst 0 (min n (length lst))))

 * (defun take (n lst)
     (check-type n (integer 0 *))
     (butlast lst (max 0 (- (length lst) n))))

 * (defun take (n lst)
     (check-type n (integer 0 *))
     (labels ((rec (lst count acc)
                (if (or (endp lst) (<= count 0))
                    (nreverse acc)
                    (rec (rest lst) (1- count)
                         (cons (first lst) acc)))))
       (rec lst n nil)))"
  :reference
  nil
  :test-env
  nil
  :test
  ((=>? (take 0 '(0 1 2)) ())
   (=>? (take 1 '(0 1 2)) (0))
   (=>? (take 2 '(0 1 2)) (0 1))
   (=>? (take 3 '(0 1 2)) (0 1 2))
   (=>? (take 4 '(0 1 2)) (0 1 2))
   (=>error? (take -1 '(0 1 2))))
  )
