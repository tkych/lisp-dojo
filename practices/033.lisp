;;;; Last modified: 2013-10-15 17:31:41 tkych

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
"
  :hint
  nil
  :solutions "
 * (defun suffixp (suffix lst &key (test #'eql))
     (cond ((endp suffix) t)
           ((endp lst)    nil)
           (t (every (lambda (x y) (funcall test x y))
                     (reverse suffix) (reverse lst)))))

 * (defun suffixp (suffix lst &key (test #'eql))
     (cond ((endp suffix) t)
           ((endp lst)    nil)
           (t (loop for s in (reverse suffix)
                    for x in (reverse lst)
                    always (funcall test s x)))))"
  :reference "
 * http://www.geocities.jp/m_hiroi/clisp/index.html"
  :test-env
  nil
  :test
  ((=>? (suffixp '() '(1 2 3))          T)
   (=>? (suffixp '(1 2 3) '())          NIL)
   (=>? (suffixp '(0 1 2 3 4) '(0 1 2)) NIL)
   (=>? (suffixp '(0 1 2 3 4) '(1 2 3)) NIL)
   (=>? (suffixp '(1 2 3) '(0 1 2 3))   T))
  )
