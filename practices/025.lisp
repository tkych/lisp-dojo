;;;; Last modified: 2013-10-13 21:34:31 tkych

(define-practice
  :id       025
  :name     flatten
  :level    1
  :problem "
 FLATTEN nested-list => flatten-list

   Make function FLATTEN.


 Examples:

   (flatten 'a)       => (A)
   (flatten '())      => NIL
   (flatten '(a b c)) => (A B C)
   (flatten '((a) ((b)) (((c)))))       => (A B C)
   (flatten '((a ((b))) (((c d (e)))))) => (A B C D E)
"
  :hint
  nil
  :solutions "
 * (defun flatten (x)
     (labels ((rec (x acc)
                (cond ((null x) acc)
                      ((atom x) (cons x acc))
                      (t (rec (car x) (rec (cdr x) acc))))))
       (rec x nil)))"
  :reference "
 * On Lisp"
  :test-env
  nil
  :test
  ((=>? (flatten 'a)       (A))
   (=>? (flatten '())      NIL)
   (=>? (flatten '(a b c)) (A B C))
   (=>? (flatten '((a) ((b)) (((c)))))
        (A B C))
   (=>? (flatten '((a ((b))) (((c d (e))))))
        (A B C D E)))
  )
