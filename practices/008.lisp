;;;; Last modified: 2013-10-15 18:57:55 tkych

(define-practice
  :id       008
  :name     my-append
  :level    0
  :problem "
 MY-APPEND list1 list2 => list

   Make function MY-APPEND.
   It returns a new list that is the concatenation of `list1' and `list2'.

 Examples:

   (my-append '()      '())      => ()
   (my-append '()      '(3 4 5)) => (3 4 5)
   (my-append '(0 1 2) '())      => (0 1 2)
   (my-append '(0 1 2) '(3 4 5)) => (0 1 2 3 4 5)
" 
  :hint
  nil
  :solutions "
 * (defun my-append (lst1 lst2)
     (labels ((rec (xs ys)
                (if (endp xs)
                    ys
                    (rec (rest xs) (cons (first xs) ys)))))
       (rec (reverse lst1) lst2)))

 * (defun my-append (lst1 lst2)
     (if (endp lst1)
         lst2
         (cons (first lst1)
               (my-append (rest lst1) lst2))))
"
  :reference "
* http://www.lispworks.com/documentation/HyperSpec/Body/f_append.htm#append"
  :test-env
  nil
  :test
  ((<=>? (my-append '()      '())      (append '()      '()))
   (<=>? (my-append '()      '(3 4 5)) (append '()      '(3 4 5)))
   (<=>? (my-append '(0 1 2) '())      (append '(0 1 2) '()))
   (<=>? (my-append '(0 1 2) '(3 4 5)) (append '(0 1 2) '(3 4 5))))
  )
