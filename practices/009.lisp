;;;; Last modified: 2013-10-12 10:54:50 tkych

(define-practice
  :id       009
  :name     range
  :level    0
  :problem "
 RANGE start end => list

   Make function RANGE.
   It returns the list of numbers from `start' below `end' by step 1.

 Examples:

   (range 2 2)  => NIL
   (range 7 2)  => NIL
   (range 0 3)  => (0 1 2)
   (range -5 5) => (-5 -4 -3 -2 -1 0 1 2 3 4)
   (range 5 -5) => NIL
"
  :hint "
 * The value of `end' is not contained in reslut-list."
  :solutions "
 * (defun range (start end)
     (loop for i from start below end collect i))

 * (defun range (start end)
     (do ((i start (1+ i))
          (result '()))
         ((<= end i) (nreverse result))
       (push i result)))

 * (defun range (start end)
     (labels ((rec (i acc)
                (if (<= end i)
                    (nreverse acc)
                    (rec (1+ i) (cons i acc)))))
       (rec start '())))"
  :reference "
 * Python's range function."
  :test-env
  nil
  :test
  ((=>? (range 2 2)     NIL)
   (=>? (range 7 2)     NIL)
   (=>? (range 5 -5)    NIL)
   (=>? (range -5 -5)   NIL)
   (=>? (range -5 -15)  NIL)
   (=>? (range 3 7)     (3 4 5 6))
   (=>? (range -5 5)    (-5 -4 -3 -2 -1 0 1 2 3 4)))
  )
