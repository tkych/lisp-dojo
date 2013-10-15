;;;; Last modified: 2013-10-15 17:31:12 tkych

(define-practice
  :id       032
  :name     split-at
  :level    0
  :problem "
 SPLIT-AT n list => front-list, rear-list

   Make function SPLIT-AT.


 Examples:

   (split-at 0 '(0 1 2 3 4 5)) => (), (0 1 2 3 4 5)
   (split-at 2 '(0 1 2 3 4 5)) => (0 1), (2 3 4 5)
   (split-at 7 '(0 1 2 3 4 5)) => (0 1 2 3 4 5), ()
   (split-at 0 '())            => (), ()
   (split-at 7 '())            => (), ()

   (split-at \"1\" '(0 1 2 3)) => ERROR!
   (split-at -1  '(0 1 2 3)) => ERROR!
"
  :hint
  nil
  :solutions "
 * (defun split-at (n lst)
     (check-type n (integer 0 *))
     (loop repeat n
           for x in lst
           collect x into acc
           finally (return (values acc (nthcdr n lst)))))

 * (defun split-at (n lst)
     (check-type n (integer 0 *))
     (labels ((rec (n top bottom)
                (if (or (<= n 0) (endp bottom))
                    (values (nreverse top) bottom)
                    (destructuring-bind (x . xs) bottom
                      (rec (1- n) (cons x top) xs)))))
       (rec n '() lst)))"
  :reference "
 * http://www.geocities.jp/m_hiroi/clisp/index.html"
  :test-env
  nil
  :test
  ((=>error? (split-at "1" '(0 1 2 3 4 5)))
   (=>error? (split-at -1  '(0 1 2 3 4 5)))
   (=>? (split-at 0 '(0 1 2 3 4 5)) (:values () (0 1 2 3 4 5)))
   (=>? (split-at 2 '(0 1 2 3 4 5)) (:values (0 1) (2 3 4 5)))
   (=>? (split-at 7 '(0 1 2 3 4 5)) (:values (0 1 2 3 4 5) ()))
   (=>? (split-at 0 '())            (:values () ()))
   (=>? (split-at 7 '())            (:values () ())))
  )
