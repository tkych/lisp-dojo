;;;; Last modified: 2013-10-15 22:52:36 tkych

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
   (prefixp '(3 4 5) '(3 4))         => NIL
"
  :hint
  nil
  :solutions "
 * (defun prefixp (prefix lst &key (test #'eql))
     (cond ((endp prefix) t)
           ((endp lst)    nil)
           (t (and (funcall test (first prefix) (first lst))
                   (prefixp (rest prefix) (rest lst))))))

 * (defun prefixp (prefix lst &key (test #'eql))
     (let ((len-prefix (length prefix))
           (len-lst (length lst)))
       (and (<= len-prefix len-lst)
            (every (lambda (x y) (funcall test x y))
                   prefix lst))))"
  :reference "
 * http://www.geocities.jp/m_hiroi/clisp/index.html"
  :test-env
  nil
  :test
  ((=>? (prefixp '() '(1 2 3))            T)
   (=>? (prefixp '(1 2 3) '())            NIL)
   (=>? (prefixp '(0 1 2 3 4) '(1 2 3))   NIL)
   (=>? (prefixp '(0 1 2 3 4) '(2 3 4))   NIL)
   (=>? (prefixp '(0 1 2 3) '(0 1 2 3 4)) T)
   (=>? (prefixp '(3 4 5) '(3 4))         NIL))
  )

