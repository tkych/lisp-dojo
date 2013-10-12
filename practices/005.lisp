;;;; Last modified: 2013-10-12 10:54:16 tkych

(define-practice
  :id       005
  :name     my-length
  :level    0
  :problem "
 MY-LENGTH list => integer

   Make function MY-LENGTH.
   It returns the number of elements in the `list'.
   Don't use buit-in function LENGTH.

 Examples:

   (my-length '())        => 0
   (my-length '(a b c d)) => 4
"
  :hint
  nil
  :solutions "
 * (defun my-length (lst)
     (if (endp lst)
         0
         (1+ (my-length (rest lst)))))

 * (defun my-length (lst)
     (labels ((rec (lst acc)
                (if (endp lst)
                    acc
                    (rec (rest lst) (1+ acc)))))
       (rec lst 0)))

 * (defun my-length (lst)
     (do ((rest lst (cdr rest))
          (length 0 (1+ length)))
         ((endp rest) length)))"
  :reference "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_length.htm#length"
  :test-env
  nil
  :test
  ((=>? (my-length '())      0)
   (=>? (my-length '(a))     1)
   (=>? (my-length '(a b c)) 3))
  )
