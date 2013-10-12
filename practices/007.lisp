;;;; Last modified: 2013-10-12 10:54:33 tkych

(define-practice
  :id       007
  :name     my-reverse
  :level    0
  :problem "
 MY-REVERSE list => reversed-list

   Make function MY-REVERSE.
   It returns a copy of the `list', containing the same elements,
   but in reverse order.
   Don't use buit-in function REVERSE.

 Examples:

   (my-reverse '())          => NIL
   (my-reverse '(a))         => (A)
   (my-reverse '(a b c))     => (C B A)
   (my-reverse '(a b (c d))) => ((C D) B A)
"
  :hint
  nil
  :solutions "
 * (defun my-reverse (xs)
     (let ((reversed '()))
       (dolist (x xs)
         (push x reversed))
       reversed))

 * (defun my-reverse (xs)
     (labels ((rec (ys acc)
                (if (endp ys)
                    acc
                    (rec (rest ys) (cons (first ys) acc)))))
       (rec xs nil)))"
  :reference  "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_revers.htm#reverse"
  :test-env
  nil
  :test
  ((<=>? (my-reverse '())          (reverse '()))
   (<=>? (my-reverse '(a))         (reverse '(a)))
   (<=>? (my-reverse '(a b c d))   (reverse '(a b c d)))
   (<=>? (my-reverse '(a b (c d))) (reverse '(a b (c d)))))
  )
