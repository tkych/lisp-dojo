;;;; Last modified: 2013-10-12 10:55:12 tkych

(define-practice
  :id       011
  :name     repeat
  :level    0
  :problem "
 REPEAT n item => list 

   Make function REPEAT.
   It returns a list of `item's with `n' length.

 Examples:

   (repeat 0 \"ok\") => NIL
   (repeat 5 \"ok\") => (\"ok\" \"ok\" \"ok\" \"ok\" \"ok\")
"
  :hint
  nil
  :solutions "
 * (defun repeat (n item)
     (make-list n :initial-element item))

 * (defun repeat (n item)
     (loop repeat n collect item))

 * (defun repeat (n item)
     (let ((acc '()))
       (dotimes (_ n)
         (push item acc))
       acc))"
  :reference
  nil
  :test-env
  nil
  :test
  ((=>? (repeat 0 "ok") NIL)
   (=>? (repeat 5 "ok") ("ok" "ok" "ok" "ok" "ok")))
  )
