;;;; Last modified: 2013-10-15 18:58:20 tkych

(define-practice
  :id       003
  :name     my-last
  :level    0
  :problem "
 MY-LAST list => cons/null

   Make function MY-LAST.
   It returns the last cons of a `list'. If `list' is (), returns ().

 Examples:

   (my-last '())          => NIL
   (my-last '(a b c d))   => (D)
   (my-last '(a b (c d))) => ((C D))
"
  :hint
  nil
  :solutions "
 * (defun my-last (lst)
     (if (endp (rest lst))
         lst
         (my-last (rest lst))))"
  :reference "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_last.htm#last"
  :test-env
  nil
  :test
  ((<=>? (my-last '())          (last '()))
   (<=>? (my-last '(a b c d))   (last '(a b c d)))
   (<=>? (my-last '(a b (c d))) (last '(a b (c d)))))
  )
