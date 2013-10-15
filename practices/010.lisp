;;;; Last modified: 2013-10-15 18:57:38 tkych

(define-practice
  :id       010
  :name     my-butlast
  :level    1
  :problem "
 MY-BUTLAST list => result-list

   Make function MY-BUTLAST.
   It returns a copy of `list' from which the last cons have been
   omitted.

 Examples:

   (my-butlast '())          => ()
   (my-butlast '(a))         => ()
   (my-butlast '(a b c d))   => (A B C)
   (my-butlast '(a b (c d))) => (A B)
"
  :hint
  nil
  :solutions "
 * (defun my-butlast (lst)
     (labels ((rec (lst acc)
                (if (endp (rest lst))
                    (reverse acc)
                    (rec (rest lst) (cons (first lst) acc)))))
       (rec lst nil)))

 * (defun my-butlast (lst)
     (labels ((rec (lst acc)
                (destructuring-bind (x . xs) lst
                  (if (endp xs)
                      (reverse acc)
                      (rec xs (cons x acc))))))
       (when lst
         (rec lst nil))))"
  :reference  "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_butlas.htm#butlast"
  :test-env
  nil
  :test
  ((<=>? (my-butlast '())          (butlast '()))
   (<=>? (my-butlast '(a))         (butlast '(a)))
   (<=>? (my-butlast '(a b c d))   (butlast '(a b c d)))
   (<=>? (my-butlast '(a b (c d))) (butlast '(a b (c d)))))
  )
