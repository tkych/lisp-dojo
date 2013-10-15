;;;; Last modified: 2013-10-15 19:02:07 tkych

(define-practice
  :id       032
  :name     prefixp
  :level    0
  :problem "
 PREFIXP prefix list &key (test #'eql) => boolean

   Make function PREFIXP.
   If `list' contains `prefix' as front-sublist, it returns T,
   otherwise NIL.

 Examples:

   (prefixp '() '(1 2 3))            => T
   (prefixp '(1 2 3) '())            => NIL
   (prefixp '(0 1 2 3 4) '(1 2 3))   => NIL
   (prefixp '(0 1 2 3 4) '(2 3 4))   => NIL
   (prefixp '(0 1 2 3) '(0 1 2 3 4)) => T
"
  :hint
  nil
  :solutions "
 * (defun prefixp (prefix lst &key (test #'eql))
     (cond ((endp prefix) t)
           ((endp lst)    nil)
           (t (every (lambda (x y) (funcall test x y))
                     prefix lst))))

 * (defun prefixp (prefix lst &key (test #'eql))
     (cond ((endp prefix) t)
           ((endp lst)    nil)
           (t (and (funcall test (first prefix) (first lst))
                   (prefixp (rest prefix) (rest lst))))))

 * (defun prefixp (prefix lst &key (test #'eql))
     (cond ((endp prefix) t)
           ((endp lst)    nil)
           (t (loop for s in prefix
                    for x in lst
                    always (funcall test s x)))))"
  :reference "
 * http://www.geocities.jp/m_hiroi/clisp/index.html"
  :test-env
  nil
  :test
  ((=>? (prefixp '() '(1 2 3))            T)
   (=>? (prefixp '(1 2 3) '())            NIL)
   (=>? (prefixp '(0 1 2 3 4) '(1 2 3))   NIL)
   (=>? (prefixp '(0 1 2 3 4) '(2 3 4))   NIL)
   (=>? (prefixp '(0 1 2 3) '(0 1 2 3 4)) T))
  )
