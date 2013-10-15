;;;; Last modified: 2013-10-15 18:59:44 tkych

(define-practice
  :id       019
  :name     range2
  :level    1
  :problem "
 RANGE2 start end &optional (step 1) => list

   Make function RANGE2.
   It returns the list of numbers from `start' below `end'
   by step `step'.

 Examples:

   (range2 2 2)     => ()
   (range2 7 2)     => ()
   (range2 0 3)     => (0 1 2)
   (range2 0 10 2)  => (0 2 4 6 8)
   (range2 -5 5)    => (-5 -4 -3 -2 -1 0 1 2 3 4)
   (range2 5 -5)    => ()
   (range2 5 -5 -1) => (5 4 3 2 1 0 -1 -2 -3 -4)
"
  :hint
  nil
  :solutions "
 * (defun range2 (start end &optional (step 1))
     (if (plusp step)
         (loop for i from start below end by step
               collect i)
         (loop for i from (- start) below (- end) by (- step)
               collect (- i))))

 * (defun range2 (start end &optional (step 1))
     (let ((finishp (if (plusp step) #'<= #'>=)))
       (do ((i start (+ i step))
            (result '()))
           ((funcall finishp end i) (nreverse result))
         (push i result))))

 * (defun range2 (start end &optional (step 1))
     (let ((finishp (if (plusp step) #'<= #'>=)))
       (labels ((rec (i acc)
                  (if (funcall finishp end i)
                      (nreverse acc)
                      (rec (+ i step) (cons i acc)))))
         (rec start '()))))
"
  :reference "
 * Python's range function."
  :test-env
  nil
  :test
  ((=>? (range2 2 2)     ())
   (=>? (range2 7 2)     ())
   (=>? (range2 5 -5)    ())
   (=>? (range2 -5 -5)   ())
   (=>? (range2 -5 -15)  ())
   (=>? (range2 3 7)     (3 4 5 6))
   (=>? (range2 0 10 2)  (0 2 4 6 8))
   (=>? (range2 -5 5)    (-5 -4 -3 -2 -1 0 1 2 3 4))
   (=>? (range2 5 -4 -1) (5 4 3 2 1 0 -1 -2 -3))
   (=>? (range2 5 -5 -2) (5 3 1 -1 -3)))
  )
