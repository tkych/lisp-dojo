;;;; Last modified: 2013-10-12 10:55:39 tkych

(define-practice
  :id       013
  :name     beforep
  :level    0
  :problem "
 BEFOREP x y list => generalized-boolean

   Make function BEFOREP.
   If `x' is before than `y' in `list', then it returns sublist of
   `list' starting `x', otherwise NIL.

 Examples:

   (beforep 2 3 '(0 1 2 3 4)) => (2 3 4)
   (beforep 2 1 '(0 1 2 3 4)) => NIL
   (beforep 1 7 '(0 1 2 3 4)) => (1 2 3 4)
   (beforep 1 7 '())          => NIL
"
  :hint
  nil
  :solutions "
 * (defun beforep (x y lst)
     (and lst
          (let ((first (car lst)))
            (cond ((equal y first) nil)
                  ((equal x first) lst)
                  (t (beforep x y (cdr lst)))))))

 * (defun beforep (x y lst)
     (loop for sub on lst
           for e = (first sub)
           do (cond ((equal y e) (return nil))
                    ((equal x e) (return sub)))))
"
  :reference "
 * On Lisp, before
"
  :test-env
  nil
  :test
  ((=>? (beforep 2 3 '(0 1 2 3 4)) (2 3 4))
   (=>? (beforep 2 1 '(0 1 2 3 4)) NIL)
   (=>? (beforep 1 7 '(0 1 2 3 4)) (1 2 3 4))
   (=>? (beforep 1 7 '())          NIL))
  )
