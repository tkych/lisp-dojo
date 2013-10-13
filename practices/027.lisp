;;;; Last modified: 2013-10-13 21:36:46 tkych

(define-practice
  :id       027
  :name     iota
  :level    1
  :problem  "
 IOTA n &key (start 0) (step 1) => list

   Make function IOTA.
   It returns a list of `n' numbers, starting from `start' (with numeric contagion
   from `step' applied), each consequtive number being the sum of the previous one
   and `step'.

 Examples:

   (iota 4)                      => (0 1 2 3)
   (iota 3 :start 1 :step 1.0)   => (1.0 2.0 3.0)
   (iota 3 :start -1 :step -1/2) => (-1 -3/2 -2)
   (iota 0)                      => ()
   (iota -1)                     => ERROR!
"
  :hint
  nil
  :solutions "
 * (defun iota (n &key (start 0) (step 1))
     (check-type n (integer 0 *))
     (loop repeat n
           for i = (+ start (- step step)) ; +-step are for non-integer step
                 then (+ i step)
           collect i))

 * (defun iota (n &key (start 0) (step 1))
     (check-type n (integer 0 *))
     (do ((i 0 (+ i 1))
          (j (+ start (* (1- n) step)) (- j step))
          (acc nil (cons j acc)))
         ((<= n i) acc)))"
  :reference "
 * alexandria:iota"
  :test-env
  nil
  :test
  ((=>? (iota 0)                      NIL)
   (=>? (iota 4)                      (0 1 2 3))
   (=>? (iota 3 :start 1 :step 1.0)   (1.0 2.0 3.0))
   (=>? (iota 3 :start -1 :step -1/2) (-1 -3/2 -2)))
  )
