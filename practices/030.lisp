;;;; Last modified: 2013-10-15 17:29:40 tkych

(define-practice
  :id       030
  :name     sublist
  :level    1
  :problem "
 SUBLIST list start &optional end => result-list

   Make function SUBLIST.
   It returns a list that is a copy of the sublist of `list' bounded
   by `start' and `end'.

 Examples:

   (sublist '(0 1 2)  0) => (0 1 2)
   (sublist '(0 1 2)  1) => (1 2)
   (sublist '(0 1 2)  2) => (2)
   (sublist '(0 1 2)  3) => ()
   (sublist '(0 1 2)  4) => ()

   (sublist '(0 1 2)  0 0) => ()
   (sublist '(0 1 2)  0 1) => (0)
   (sublist '(0 1 2)  0 2) => (0 1)
   (sublist '(0 1 2)  0 3) => (0 1 2)
   (sublist '(0 1 2)  0 4) => (0 1 2)

   (sublist '(0 1 2) -1)   => ERROR!
   (sublist '(0 1 2) 1 0)  => ERROR!
   (sublist '(0 1 2) 1 -1) => ERROR!
"
  :hint
  nil
  :solutions "
 * (defun sublist (lst start &optional end)
     (check-type start (integer 0 *))
     (check-type end   (or null (integer 0 *)))
     (when (and end (< end start))
       (error \"end ~D < start ~D\" end start))
     (loop for i from 0
           for x in lst
           when (and (<= start i)
                     (or (null end)
                         (and end (< i end))))
             collect x))

 * (defun sublist (lst start &optional end)
     (check-type start (integer 0 *))
     (check-type end   (or null (integer 0 *)))
     (if (null end)
         (drop start lst)
         (if (< end start)
             (error \"end ~D < start ~D\" end start)
             (take end (drop start lst)))))"
  :reference "
 * http://www.lispworks.com/documentation/HyperSpec/Body/f_subseq.htm#subseq"
  :test-env
  nil
  :test
  ((=>error? (sublist '(0 1 2) -1))
   (=>error? (sublist '(0 1 2) 1 0))
   (=>error? (sublist '(0 1 2) 1 -1))
   
   (=>? (sublist '(0 1 2)  0) (0 1 2))
   (=>? (sublist '(0 1 2)  1) (1 2))
   (=>? (sublist '(0 1 2)  2) (2))
   (=>? (sublist '(0 1 2)  3) ())
   (=>? (sublist '(0 1 2)  4) ())

   (=>? (sublist '(0 1 2)  0 0) ())
   (=>? (sublist '(0 1 2)  0 1) (0))
   (=>? (sublist '(0 1 2)  0 2) (0 1))
   (=>? (sublist '(0 1 2)  0 3) (0 1 2))
   (=>? (sublist '(0 1 2)  0 4) (0 1 2)))
  )
