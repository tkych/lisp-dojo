;;;; Last modified: 2013-10-12 10:55:24 tkych

(define-practice
  :id       012
  :name     my-count
  :level    0
  :problem "
 MY-COUNT item list => integer

   Make function MY-COUNT.
   It returns number of `item' in the `list'.
   Don't use buit-in function COUNT.

 Examples:

   (my-count 'a '())          => 0
   (my-count 'a '(a))         => 1
   (my-count 'a '(z a b))     => 1
   (my-count 'a '(a z a b a)) => 3
   (my-count \"a\" '(\"a\" z a b \"a\")) => 2
" 
  :hint
  nil
  :solutions "
 * (defun my-count (item lst)
     (loop for x in lst count (equal x item)))

 * (defun my-count (item lst)
     (let ((count 0))
       (dolist (x lst)
         (when (equal x item)
           (incf count)))
       count))"
  :reference "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_countc.htm#count"
  :test-env
  nil
  :test
  ((=>? (my-count 'a '())          0)
   (=>? (my-count 'a '(a))         1)
   (=>? (my-count 'a '(z a b))     1)
   (=>? (my-count 'a '(a z a b a)) 3)
   (=>? (my-count "a" '("a" z a b "a")) 2))
  )
