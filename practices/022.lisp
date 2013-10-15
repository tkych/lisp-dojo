;;;; Last modified: 2013-10-15 19:00:21 tkych

(define-practice
  :id       022
  :name     zip~unzip
  :level    1
  :problem "
 ZIP &rest lists => zipped-lists
 UNZIP &rest lists => unziped-lists

   Make function ZIP & UNZIP

 Examples:

   (zip '())               => ()
   (zip '(a b c))          => ((A) (B) (C))
   (zip '(a b c) '(0 1 2)) => ((A 0) (B 1) (C 2))
   (zip '(a b c) '(0 1))   => ((A 0) (B 1))
   (zip '(a b)   '(0 1 2)) => ((A 0) (B 1))

   (unzip '())                  => ()
   (unzip '(A 0) '(B 1) '(C 2)) => ((A B C) (0 1 2))
   (unzip '(A 0) '(B 1) '(C))   => ((A B C))

   (apply #'unzip (zip '(a b c) '(0 1 2)))   => ((A B C) (0 1 2))
   (apply #'zip (unzip '(A 0) '(B 1) '(C 2))) => ((A 0) (B 1) (C 2))
"
  :hint "
 * ZIP and UNZIP are the same function with defferent names."
  :solutions "
 * (defun zip (&rest lists)
     (apply #'mapcar #'list lists))

 * (defun unzip (&rest lists)
     (apply #'mapcar #'list lists))
"
  :reference "
 * Python's ZIP function"
  :test-env
  nil
  :test
  ((=>? (zip '())               ())
   (=>? (zip '(a b c))          ((A) (B) (C)))
   (=>? (zip '(a b c) '(0 1 2)) ((A 0) (B 1) (C 2)))
   (=>? (zip '(a b c) '(0 1))   ((A 0) (B 1)))
   (=>? (zip '(a b)   '(0 1 2)) ((A 0) (B 1)))

   (=>? (unzip '())                                ())
   (=>? (unzip '(A 0) '(B 1) '(C 2))               ((A B C) (0 1 2)))
   (=>? (unzip '(A 0) '(B 1) '(C))                 ((A B C)))

   (=>? (apply #'unzip (zip '(a b c) '(0 1 2)))    ((A B C) (0 1 2)))
   (=>? (apply #'zip (unzip '(A 0) '(B 1) '(C 2))) ((A 0) (B 1) (C 2))))
  )
