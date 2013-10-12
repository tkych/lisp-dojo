;;;; Last modified: 2013-10-12 10:54:25 tkych

(define-practice
  :id       006
  :name     my-nth
  :level    0
  :problem "
 MY-NTH n list => object

   Make function MY-NTH.
   It returns `n'th element of `list'.
   Don't use buit-in function NTH.

 Examples:

   (my-nth 0 '())      => NIL
   (my-nth 0 '(a b c)) => A
   (my-nth 1 '(a b c)) => B
   (my-nth 2 '(a b c)) => C
   (my-nth 3 '(a b c)) => NIL
"
  :hint
  nil
  :solutions "
 * (defun my-nth (n lst)
     (if (zerop n)
         (first lst)
         (my-nth (1- n) (rest lst))))

 * (defun my-nth (n lst)
     (do ((count n (1- count))
          (rest lst (cdr rest)))
         ((or (endp rest) (<= count 0))
          (first rest))))"
  :reference "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_nth.htm#nth"
  :test-env
  nil
  :test
  ((<=>? (my-nth 0 '())      (nth 0 '()))
   (<=>? (my-nth 0 '(a b c)) (nth 0 '(a b c)))
   (<=>? (my-nth 1 '(a b c)) (nth 1 '(a b c)))
   (<=>? (my-nth 2 '(a b c)) (nth 2 '(a b c)))
   (<=>? (my-nth 7 '(a b c)) (nth 7 '(a b c))))
  )
