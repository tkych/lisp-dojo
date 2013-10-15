;;;; Last modified: 2013-10-15 17:33:15 tkych

(define-practice
  :id       034
  :name     my-subsetp
  :level    1
  :problem "
 MY-SUBSETP list1 list2 &key (test #'eql) => boolean

   Make function MY-SUBSETP.
   If `list1' is sublist of `list2', then returns T, otherwise NIL.
   Don't use buit-in function SUBSETP.

 Examples:

   (my-subsetp '()          '(1 2 3))     => T
   (my-subsetp '(1 2 3)     '())          => NIL
   (my-subsetp '(0 1 2 3 4) '(1 2 3))     => NIL
   (my-subsetp '(0 1 2)     '(1 2 3 4))   => NIL
   (my-subsetp '(0 1 2)     '(0 1 2 3 4)) => T
   (my-subsetp '(1 2 3)     '(0 1 2 3 4)) => T
   (my-subsetp '(0 1 2 3)   '(0 1 2 3))   => T
   (my-subsetp '(2 3 4)     '(0 1 2 3 4)) => T
   (my-subsetp '(3 4 5)     '(0 1 2 3 4)) => NIL
"
 
  :hint
  nil
  :solutions "
 * (defun my-subsetp (lst1 lst2 &optional (test #'eql))
     (labels ((rec (curr target)
                (cond ((endp curr)   T)
                      ((endp target) NIL)
                      (t (destructuring-bind (x . xs) target
                           (if (funcall test x (first curr))
                               (rec (rest curr) xs)
                               (rec lst1 xs)))))))
       (rec lst1 lst2)))

 * (defun my-subsetp (lst1 lst2 &optional (test #'eql))
     (let ((curr lst1))
       (dolist (x lst2)
         (if (funcall test x (first curr))
             (setf curr (rest curr))
             (setf curr lst1))
         (when (endp curr)
           (RETURN-FROM my-subsetp T)))
       NIL))

 * (defun my-subsetp (lst1 lst2 &optional (test #'eql))
     (loop for x in lst2
           with curr = lst1
           do (if (funcall test x (first curr))
                  (setf curr (rest curr))
                  (setf curr lst1))
              (when (endp curr)
                (RETURN-FROM my-subsetp T)))
     NIl)"
  :reference "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_subset.htm#subsetp"
  :test-env
  nil
  :test
  ((=>? (my-subsetp '()          '(1 2 3))     T)
   (=>? (my-subsetp '(1 2 3)     '())          NIL)
   (=>? (my-subsetp '(0 1 2 3 4) '(1 2 3))     NIL)
   (=>? (my-subsetp '(0 1 2)     '(1 2 3 4))   NIL)
   (=>? (my-subsetp '(0 1 2)     '(0 1 2 3 4)) T)
   (=>? (my-subsetp '(1 2 3)     '(0 1 2 3 4)) T)
   (=>? (my-subsetp '(0 1 2 3)   '(0 1 2 3))   T)
   (=>? (my-subsetp '(2 3 4)     '(0 1 2 3 4)) T)
   (=>? (my-subsetp '(3 4 5)     '(0 1 2 3 4)) NIL))
  )
