;;;; Last modified: 2013-10-13 21:36:23 tkych

(define-practice
  :id       026
  :name     longerp
  :level    1
  :problem "
 LONGERP list1 list2 => boolean

   Make function LONGERP.
   It returns T if `list1' is longer than `list2',  otherwise NIL.

 Examples:

   (longerp '() '())         => NIL
   (longerp '(a b c) '(a b)) => T
   (longerp '(a b)   '(a b)) => NIL
   (longerp '(a)     '(a b)) => NIL
   (longerp '()      '(a b)) => NIL
"
  :hint
  nil
  :solutions "
 * (defun longerp (lst1 lst2)
     (and (consp lst1)
          (or (null lst2)
              (longerp (rest lst1) (rest lst2)))))

 * (defun longerp (seq1 seq2)
     (labels ((compare (lst1 lst2)
                (and (consp lst1)
                     (or (null lst2)
                         (compare (rest lst1) (rest lst2))))))
       (if (and (listp seq1) (listp seq2))
           (compare seq1 seq2)
           (> (length seq1) (length seq2)))))"
  :reference "
 * On Lisp"
  :test-env
  nil
  :test
  ((=>? (longerp '(0 1 2) '(0 1)) T)
   (=>? (longerp '(0 1)   '(0 1)) NIL)
   (=>? (longerp '(0)     '(0 1)) NIL))
  )
