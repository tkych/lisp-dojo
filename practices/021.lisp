;;;; Last modified: 2013-10-15 19:00:05 tkych

(define-practice
  :id       021
  :name     my-remove-duplicate
  :level    0
  :problem "
 MY-REMOVE-DUPLICATE list => result-list

   Make function MY-REMOVE-DUPLICATE.
   It returns a modified copy of `list' from which any element that
   matches another element occurring in `list' has been removed.

 Examples:

   (my-remove-duplicate '())            => ()
   (my-remove-duplicate '(42 42 42 42)) => (42)
   (my-remove-duplicate '(0 1 2 3 0 3 3 4 4 4 1)) => (0 1 2 3 4)
   
   (my-remove-duplicate (list (copy-seq \"42\") (copy-seq \"42\")
                              (copy-seq \"42\") (copy-seq \"42\")))
   => (\"42\" \"42\" \"42\" \"42\")

   (my-remove-duplicate (list (copy-seq \"42\") (copy-seq \"42\")
                              (copy-seq \"42\") (copy-seq \"42\"))
                        :test #'equal)
   => (\"42\")"
  :hint
  nil
  :solutions "
 * (defun my-remove-duplicate (lst &key (test #'eql))
     (let ((result '()))
       (dolist (x lst)
         (pushnew x result :test test))
       (nreverse result)))

 * (defun my-remove-duplicate (lst &key (test #'eql))
     (loop for x in lst
           unless (member x already :test test)
             collect x into already
           finally (return already)))

 * (defun my-remove-duplicate (lst &key (test #'eql))
     (labels ((rec (lst already)
                (if (endp lst)
                    (nreverse already)
                    (destructuring-bind (x . xs) lst
                      (if (member x already :test test)
                          (rec xs already)
                          (rec xs (cons x already)))))))
       (rec lst '())))"
  :reference "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_rm_dup.htm#remove-duplicates"
  :test-env
  nil
  :test
  ((=>? (my-remove-duplicate '())                      ())
   (=>? (my-remove-duplicate '(42 42 42 42 42 42 42))  (42))
   (=>? (my-remove-duplicate '(0 1 2 3 0 3 3 4 4 4 1)) (0 1 2 3 4))
   
   (=>? (my-remove-duplicate (list (copy-seq "42")
                                   (copy-seq "42")
                                   (copy-seq "42")
                                   (copy-seq "42")))
        ("42" "42" "42" "42"))

   (=>? (my-remove-duplicate (list (copy-seq "42")
                                   (copy-seq "42")
                                   (copy-seq "42")
                                   (copy-seq "42"))
                             :test #'equal)
        ("42")))
  )
