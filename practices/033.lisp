;;;; Last modified: 2013-10-15 22:53:52 tkych

(define-practice
  :id       033
  :name     suffixp
  :level    0
  :problem "
 SUFFIXP suffix list &key (test #'eql) => boolean

   Make function SUFFIXP.
   If `list' contains `suffix' as rear-sublist, it returns T,
   otherwise NIL.

 Examples:

   (suffixp '() '(1 2 3))          => T
   (suffixp '(1 2 3) '())          => NIL
   (suffixp '(0 1 2 3 4) '(0 1 2)) => NIL
   (suffixp '(0 1 2 3 4) '(1 2 3)) => NIL
   (suffixp '(1 2 3) '(0 1 2 3))   => T
   (suffixp '(0 1 2) '(1 2))       => NIL
"
  :hint
  nil
  :solutions "
 * (defun suffixp (suffix lst &key (test #'eql))
     (let ((len-suffix (length suffix))
           (len-lst (length lst)))
       (and (<= len-suffix len-lst)
            (every (lambda (x y) (funcall test x y))
                   suffix (last lst len-suffix)))))"
  :reference "
 * http://www.geocities.jp/m_hiroi/clisp/index.html"
  :test-env
  nil
  :test
  ((=>? (suffixp '() '(1 2 3))          T)
   (=>? (suffixp '(1 2 3) '())          NIL)
   (=>? (suffixp '(0 1 2 3 4) '(0 1 2)) NIL)
   (=>? (suffixp '(0 1 2 3 4) '(1 2 3)) NIL)
   (=>? (suffixp '(1 2 3) '(0 1 2 3))   T)
   (=>? (suffixp '(0 1 2) '(1 2))       NIL))
  )

