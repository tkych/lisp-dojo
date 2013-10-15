;;;; Last modified: 2013-10-15 18:59:56 tkych

(define-practice
  :id       020
  :name     group
  :level    1
  :problem "
 GROUP n list => grouped-list

   Make function GROUP.
   It returns list of disjoint sublists, each sublist contains
   `n' elements like the following examples.
   If `n' is not a plus-integer, then GROUP must signal an error.

 Examples:

   (group  2 '())          => ()
   (group  1 '(0 1 2 3 4)) => ((0) (1) (2) (3) (4))
   (group  2 '(0 1 2 3 4)) => ((0 1) (2 3) (4))
   (group  3 '(0 1 2 3 4)) => ((0 1 2) (3 4))
   (group  0 '(0 1 2 3 4)) => ERROR!
   (group -1 '(0 1 2 3 4)) => ERROR!
"
  :hint
  nil
  :solutions "
 * (defun group (n lst)
     (unless (plusp n) (error \"~D is not plus length.\" n))
     (when lst
       (labels ((rec (src acc)
                  (let ((rest (nthcdr n src)))
                    (if (consp rest)
                        (rec rest (cons (subseq src 0 n) acc))
                        (nreverse (cons src acc))))))
         (rec lst nil))))"
  :reference "
 * On Lisp"
  :test-env
  nil
  :test
  ((=>? (group 2 '())          ())
   (=>? (group 1 '(0 1 2 3 4)) ((0) (1) (2) (3) (4)))
   (=>? (group 2 '(0 1 2 3 4)) ((0 1) (2 3) (4)))
   (=>? (group 3 '(0 1 2 3 4)) ((0 1 2) (3 4)))
   (=>error? (group  0 '(0 1 2 3 4)))
   (=>error? (group -2 '(0 1 2 3 4))))
  )
