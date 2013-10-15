;;;; Last modified: 2013-10-15 19:00:32 tkych

(define-practice
  :id       023
  :name     my-member
  :level    0
  :problem "
 MY-MEMBER item list => generalized-boolean

   Make function MY-MEMBER.

 Examples:

   (my-member 1 '(0 1 2 3)) => (1 2 3)
   (my-member 4 '(0 1 2 3)) => ()
   (my-member 1 '())        => ()

   (my-member \"1\" (list (copy-seq \"0\") (copy-seq \"1\")
                          (copy-seq \"2\") (copy-seq \"3\")))
   => ()
   (my-member \"1\" (list (copy-seq \"0\") (copy-seq \"1\")
                          (copy-seq \"2\") (copy-seq \"3\"))
              :test #'equal)
   => (\"1\" \"2\" \"3\")
" 
  :hint
  nil
  :solutions "
 * (defun my-member (item lst &key (test #'eql))
     (loop for xs on lst
           when (funcall test item (first xs))
             do (RETURN xs)))

 * (defun my-member (item lst &key (test #'eql))
     (if (endp lst)
         nil
         (if (funcall test item (first lst))
             lst
             (my-member item (rest lst) :test test))))

 * (defun my-member (item lst &key (test #'eql))
     (labels ((rec (lst)
                (if (endp lst)
                    nil
                    (if (funcall test item (first lst))
                        lst
                        (rec (rest lst))))))
       (rec lst)))"
  :reference "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_mem_m.htm"
  :test-env
  nil
  :test
  ((=>? (my-member 1 '(0 1 2 3)) (1 2 3))
   (=>? (my-member 4 '(0 1 2 3)) ())
   (=>? (my-member 1 '())        ())
   
   (=>? (my-member "1" (list (copy-seq "0") (copy-seq "1")
                             (copy-seq "2") (copy-seq "3")))
        ())
   (=>? (my-member "1" (list (copy-seq "0") (copy-seq "1")
                             (copy-seq "2") (copy-seq "3"))
                   :test #'equal)
        ("1" "2" "3")))
  )
