;;;; Last modified: 2013-10-15 18:54:49 tkych

;; lisp-dojo/core.lisp

;; Copyright (c) 2013 Takaya OCHIAI <tkych.repl@gmail.com>
;; This file is released under the MIT License.
;; For more details, see lisp-dojo/LICENSE

;; TODO:
;; -----
;;  * once-only print promotion message
;;  * .dojo -> your-solutions/.dojo

;; BUG:
;; ----
;;  * ./lisp-dojo check <not-generated-yet-id> => error


;;====================================================================
;; Lisp-Dojo: core
;;====================================================================

(in-package :cl-user)
(defpackage #:lisp-dojo (:use :cl))
(in-package #:lisp-dojo)


;;--------------------------------------------------------------------
;; Utils
;;--------------------------------------------------------------------

(defmacro with-gensyms (syms &body body)
  `(let ,(mapcar (lambda (s)
                   `(,s (gensym ,(concatenate 'string (string s) "-"))))
                 syms)
     ,@body))

(defun strip (string)
  (string-trim '(#\Newline) string))

;; (substitute-char-to-string #\a "####" "adsfadsf") => "####dsf####dsf"
;; as ppcre:regex-replace-all alternative
(defun substitute-char-to-string (old-char new-string target-string)
  (with-output-to-string (s)
    (loop
       :for start := 0 :then (1+ pos)
       :for pos := (position old-char target-string :start start :test #'char=)
       :until (null pos)
       :do (format s "~A~A" (subseq target-string start pos) new-string)
       :finally (princ (subseq target-string start) s))))

(defmacro dispatch-string (keyform &body clauses)
  "Same as CASE, except that the test function is #'STRING=."
  (with-gensyms (evaled-keyform)
    `(let ((,evaled-keyform ,keyform))
       (declare (ignorable ,evaled-keyform))
       (cond ,@(loop
                  :for (keys . form) :in clauses
                  :collect
                  (cond ((or (eq keys t) (eq keys 'otherwise))
                         `(t ,@form))
                        ((stringp keys)
                         `((string= ,keys ,evaled-keyform) ,@form))
                        ((listp keys)
                         (if (null (cdr keys))
                             `((string= ,(car keys) ,evaled-keyform)
                               ,@form)
                             `((or ,@(loop
                                        :for k :in keys
                                        :collect
                                        `(string= ,k ,evaled-keyform)))
                               ,@form)))))))))

(defun generate-rfc3339-date-time-string (&optional (sep #\T))
  (multiple-value-bind
        (sec min hour date month year day daylight-p zone) (get-decoded-time)
    (declare (ignore day daylight-p))
    (multiple-value-bind
          (zone-hour zone-min) (floor (abs zone))
      (setf zone-min (* zone-min 60))
      (format nil "~4,'0D-~2,'0D-~2,'0D~A~2,'0D:~2,'0D:~2,'0D~A~2,'0D:~2,'0D"
              year month date sep hour min sec
              (if (plusp zone) #\- #\+)
              zone-hour zone-min))))

(defstruct (<lazy> (:constructor make-lazy)
                   (:conc-name   lazy-))
  body
  forced-p)

(defmacro be-lazy (&body body)
  `(make-lazy :body (lambda () ,@body)
              :forced-p nil))

(defun force (object)
  (if (typep object '<lazy>)
      (if (lazy-forced-p object)
          (lazy-body object)
          (setf (lazy-forced-p object) t
                (lazy-body object)     (funcall (lazy-body object))))
      object))

(defmacro with-print-downcase-symbols (&body body)
  `(let ((*print-case* :downcase))
     ,@body))


;;--------------------------------------------------------------------
;; Special Variables
;;--------------------------------------------------------------------

(defparameter *practices-directory* "practices")
(defparameter *solutions-directory* "your-solutions")

(defparameter *total-num-practices* 34)
(defparameter *promotion-rate* 10)

(defparameter *belts*
  #("white-belt"
    "red-belt"
    "green-belt"
    "orenge-belt"
    "yellow-belt"
    "blue-belt"
    "indigo-belt"
    "violet-belt"
    "black-belt"

    ;; secret-dojo
    ;; "Master-of-Wind"
    ;; "Master-of-Forest"
    ;; "Master-of-Fire"
    ;; "Master-of-Mountain"
    ;; "Master-of-Shadow"
    ;; "Master-of-Thunder"
    ))

(defvar *current-practice* nil)
(defvar *progress* 0)

(defparameter *under-construction-message*
  "Sorry, documentation is under construction.")


;;--------------------------------------------------------------------
;; Practices
;;--------------------------------------------------------------------

(defclass <practice> ()
  ((id        :type (integer 0 *)    :reader get-id        :initarg :id)
   (name      :type symbol           :reader get-name      :initarg :name)
   (level     :type (integer 0 3)    :reader get-level     :initarg :level)
   (problem   :type string           :reader get-problem   :initarg :problem)
   (hint      :type (or null string) :reader get-hint      :initarg :hint)
   (test-env  :type (or null <lazy>) :reader get-test-env  :initarg :test-env)
   (test-fn   :type <lazy>           :reader get-test-fn   :initarg :test-fn)
   (solutions :type (or null string) :reader get-solutions :initarg :solutions)
   (reference :type (or null string) :reader get-reference :initarg :reference)))


(defmacro define-practice (&key id name level problem hint
                             solutions test-env test reference)
  `(setf *current-practice*
         (make-instance '<practice>
                        :id        ,id
                        :name      ',name
                        :level     ,level
                        :problem   ,problem
                        :hint      ,hint
                        :test-env  ,(when test-env
                                      `(generate-test-env ,test-env))
                        :test-fn   (generate-test-fn ,@test)
                        :reference ,reference
                        :solutions ,solutions)))


;;--------------------------------------------------------------------
;; Eval-Tests
;;--------------------------------------------------------------------

(defmacro =>? (expr want)
  (if (and (listp want) (eq (first want) :values))
      
      ;; 0. Multiple values case
      (with-gensyms (eval-test want-values evaled-values result)
        `(be-lazy
           (with-print-downcase-symbols
             (block ,eval-test
               (let* ((,want-values ',(rest want))
                      (,evaled-values
                        (handler-case (multiple-value-list ,expr)
                          (error (condition)
                            (return-from ,eval-test
                              (format t "~&[31mFAIL ... ~S =>? ~{~S~^, ~} ... =>[0m [33m~@:(~A~)[0m~%"
                                      ',expr ,want-values (type-of condition))))))
                      (,result (equal ,evaled-values ,want-values)))
                 (if ,result
                     (format t "~&[32mPASS ... ~S => ~{~S~^, ~}[0m~%"
                             ',expr ,want-values)
                     (format t "~&[31mFAIL ... ~S =>? ~{~S~^, ~} ... => ~{~S~^, ~}[0m~%"
                             ',expr ,want-values ,evaled-values))
                 ,result)))))
      
      ;; 1. Single value case
      (with-gensyms (eval-test evaled result)
        `(be-lazy
           (with-print-downcase-symbols
             (block ,eval-test
               (let* ((,evaled
                        (handler-case ,expr
                          (error (condition)
                            (return-from ,eval-test
                              (format t "~&[31mFAIL ... ~S =>? ~S ... =>[0m [33m~@:(~A~)[0m~%"
                                      ',expr ',want (type-of condition))))))
                      (,result (equal ,evaled ',want)))
                 (if ,result
                     (format t "~&[32mPASS ... ~S => ~S[0m~%"
                             ',expr ',want)
                     (format t "~&[31mFAIL ... ~S =>? ~S ... => ~S[0m~%"
                             ',expr ',want ,evaled))
                 ,result)))))))

(defmacro <=>? (expr want)
  (with-gensyms (eval-test want-values evaled-values result)
    `(be-lazy
       (with-print-downcase-symbols
         (block ,eval-test
           (let* ((,want-values (multiple-value-list ,want))
                  (,evaled-values
                    (handler-case (multiple-value-list ,expr)
                      (error (condition)
                        (return-from ,eval-test
                          (format t "~&[31mFAIL ... ~S =>? ~{~S~^, ~} ... =>[0m [33m~@:(~A~)[0m~%"
                                  ',expr ,want-values (type-of condition))))))
                  (,result (equal ,evaled-values ,want-values)))
             (if ,result
                 (format t "~&[32mPASS ... ~S => ~{~S~^, ~}[0m~%"
                         ',expr ,want-values)
                 (format t "~&[31mFAIL ... ~S =>? ~{~S~^, ~} ... => ~{~S~^, ~}[0m~%"
                         ',expr ,want-values ,evaled-values))
             ,result))))))

(defmacro =>error? (expr)
  (with-gensyms (errored evaled condition result)
    `(be-lazy
       (with-print-downcase-symbols
         (multiple-value-bind (,evaled ,condition)
             (handler-case
                 (values ,expr NIL)
               (error (c) (values ',errored c)))
           (let ((,result (equal ,evaled ',errored)))
             (if ,result
                 (format t "~&[32mPASS ... ~S =>[0m [33m~@:(~A~)[0m~%"
                         ',expr (type-of ,condition))
                 (format t "~&[31mFAIL ... ~S =>?[0m [33mERROR[0m [31m... => ~S[0m~%"
                         ',expr ,evaled))
             ,result))))))

(defun generate-test-fn (&rest tests)
  (be-lazy
    (loop
      :for test :in tests
      :collect (force test) :into result
      :finally (return (every #'identity result)))))

(defmacro generate-test-env (exprs)
  `(be-lazy
     ,@exprs
     (with-print-downcase-symbols
         ,@(loop :for expr :in exprs
                 :collect `(format t "~&ENV  ... ~A~%" ',expr)))))


;;--------------------------------------------------------------------
;; Progress
;;--------------------------------------------------------------------
;; 42 (<=> #b101010) ~ {1 3 5}

(defun overcome-practice (id)
  (setf *progress* (logior *progress* (ash 2 (1- id)))))

(defun overcamep (id)
  (logbitp id *progress*))

(defun get-num-overcame ()
  (logcount *progress*))

(defun promotep ()
  (zerop (mod (1- (get-num-overcame)) *promotion-rate*)))

(defun get-current-belt ()
  (svref *belts* (floor (get-num-overcame) *promotion-rate*)))


;;--------------------------------------------------------------------
;; File I/O
;;--------------------------------------------------------------------

(defun make-practice-filespec (id)
  (format nil "~A/~3,'0D.lisp" *practices-directory* id))

(defun make-solution-filespec (id name)
  (format nil "~A/~3,'0D-~(~A~).lisp" *solutions-directory* id name))

(defmacro with-quiet-error-output (&body body)
  `(let ((*error-output*
          (make-two-way-stream (make-concatenated-stream)
                               (make-broadcast-stream))))
     ,@body))


;; MEMO: 2013-10-12
;; load's verbose default is the value of *load-verbose*.
;; The initial value of *load-verbose* is implementation-dependent.
;; c.f. CLHS, Function LOAD, Variable *LOAD-VERBOSE*

(defun load-practice (id)
  (with-quiet-error-output
    (load (make-practice-filespec id) :verbose nil)))

;; for DBG
;; (defun load-practice (id)
;;   (load (make-practice-filespec id) :verbose nil))

(defun load-solution (id name)
  (with-quiet-error-output
    (load (make-solution-filespec id name) :verbose nil)))

(defun read-dot-dojo ()
  (if (not (probe-file #p".dojo"))
      ;; If dot-dojo file is missing, we count progress 0.
      ;; A new dot-dojo file will generate when function
      ;; WRITE-DOTO-DOJO is called.
      (setf *progress* 0)
      (with-open-file (in #p".dojo")
        (let ((progress (read in)))
          (if (integerp progress)
              (setf *progress* progress)
              (error "~S is unknown dot-dojo format." progress))))))

;; TODO: once-only print promotion message
;; (defvar *promotion* 0)

;; (defun read-dot-dojo ()
;;   (if (not (probe-file #p".dojo"))
;;       ;; If dot-dojo file is missing, we count progress 0.
;;       ;; A new dot-dojo file will generate when function
;;       ;; WRITE-DOTO-DOJO is called.
;;       (setf *progress* 0)
;;       (with-open-file (in #p".dojo")
;;         (aif (integerp (read in))
;;              (setf *progress* it)
;;              (error "~S is unknown dot-dojo format." it))
;;         (aif (integerp (read in))
;;              (setf *promotion* it)
;;              (error "~S is unknown dot-dojo format." it)))))

(defun write-dot-dojo ()
  (with-open-file (out #p".dojo" :direction :output
                                 :if-exists :supersede
                                 :if-does-not-exist :create)
    (write *progress*  :stream out)))

(defun generate-practice-title (id name level)
  (format nil "~D. ~A~A~A" id name
        (if (zerop level) "" " ")
        (make-string level :initial-element #\*)))

(defun make-solution-file (id)
  (load-practice id)
  (with-slots (name problem level) *current-practice*
    (let ((solution-filespec (make-solution-filespec id name)))
      (with-open-file (out solution-filespec
                           :direction :output
                           :if-does-not-exist :create
                           :if-exists :supersede)
        (format out ";;;; Created: ~A lisp-dojo~%"
                (generate-rfc3339-date-time-string #\Space))
        (format out "
;;====================================================================
;; ~A
;;====================================================================
;; ~A
;;--------------------------------------------------------------------



;;====================================================================
"
                (generate-practice-title id name level)
                (substitute-char-to-string #\Newline "
;; " problem))
        (format t "New solution file generated: ~A~%" solution-filespec)))))


;;--------------------------------------------------------------------
;; Print
;;--------------------------------------------------------------------

(defparameter *lisp-road*
  "                                      __     __   __
    _                                 \\_\\   _\\ \\_/ /_
   | |         _     ____    _____   _____ |_________|
   | |        |_|   / __ \\  |  __ \\  \\_  _\\   _/ /_
   | |         _    \\ \\ \\_\\ | |  \\ |   \\ \\   ||___||
   | |        | | __ \\ \\    | |__/ |    | |  ||___||
   | |______  | | \\ \\_\\ \\   |  ___/    / / _ ||___||  __
   |________| |_|  \\____/   | |       / /_/ \\||___||_/ /
                            |_|       \\___/-\\_________/

                         --- The Road Leads to The Lisp Master")

(defparameter *completion*
  "
                                                                 [1;32m\\o/[0m
                                     [1;32m__     __   __[0m               [1;32m|[0m        [1;31;1m___[0m
  [1;36m _ [0m                                [1;32m\\_\\   _\\ \\_/ /_[0m           [1;37m__[0m[1;32m/[0m[1;37m_[0m[1;32m\\[0m[1;37m__[0m    [1;31;1m/   \\[0m
  [1;36m| |[0m        [1;35m _ [0m   [1;33m ____ [0m   [1;31m_____[0m   [1;32m_____ |_________|[0m         [1;37m/        \\[0m  [1;31;1m\\___/[0m
  [1;36m| |[0m        [1;35m|_|[0m   [1;33m/ __ \\[0m  [1;31m|  __ \\ [0m [1;32m\\_  _\\   _/ /_[0m           [1;37m/          \\[0m
  [1;36m| |[0m        [1;35m _ [0m   [1;33m\\ \\ \\_\\[0m [1;31m| |  \\ |[0m[1;32m   \\ \\   ||___||[0m         [1;34m/[0m[1;37m\\  /\\  /\\  /[0m[1;34m\\[0m
  [1;36m| |[0m        [1;35m| |[0m [1;33m__ \\ \\ [0m   [1;31m| |__/ |[0m    [1;32m| |  ||___||[0m        [1;34m/[0m  [1;37m\\/  \\/  \\/[0m  [1;34m\\[0m
  [1;36m| |______ [0m [1;35m| |[0m [1;33m\\ \\_\\ \\[0m   [1;31m|  ___/[0m    [1;32m/ / _ ||___||  __[0m   [1;34m/                \\[0m
  [1;36m|________|[0m [1;35m|_|[0m  [1;33m\\____/[0m   [1;31m| |[0m       [1;32m/ /_/ \\||___||_/ /[0m  [1;34m/                  \\[0m
                           [1;31m|_|[0m       [1;32m\\___/-\\_________/[0m  [1;34m/                    \\[0m

            --- Genius is a little boy chasing a butterfly up a mountain.
")

(defun print-success-message (id name)
  (format t "[1;32mAll Tests Passed -- Challenge next practice in ~A[0m~%"
          (make-solution-filespec id name)))

(defun print-fail-message (id name)
  (format t "[1;31mSome Tests Failed --- Try again this practice in ~A[0m~%"
          (make-solution-filespec id name)))

(defun get-progress-bars ()
  (let* ((bar (replace
               (make-string *total-num-practices* :initial-element #\_)
               (substitute #\* #\1
                           (substitute #\_ #\0
                                       (nreverse (format nil "~B" *progress*))))))
         (len (length bar)))
    (loop :for start :from 0 :by 70
          :for end := (min len (+ start 70))
          :until (< *total-num-practices* start)
          :append (list (subseq bar start end)
                        (with-output-to-string (s)
                          (loop :for i :from start :below end
                                :do (multiple-value-bind (f r) (floor (1+ i) 10)
                                      (if (zerop r)
                                          (princ f s)
                                          (princ #\Space s)))))))))

(defun print-progress ()
  (format t "~&~@:(~A~): ~D~%"
          (get-current-belt) (get-num-overcame))
  (format t "~&~{~A~^~%~}" (get-progress-bars)))


;; "Love the lisp you live. Live the lisp you love."
(defparameter *promotion-massage*
  #("A cat has nine lisps."   ;dummy
    "A journey of a thousand miles begins with a single step." ;white-belt
    "There is no royal road to learning lisp."        ;red-belt
    "At the touch of lisp, everyone becomes a poet."  ;green-belt
    "Thou shouldst eat to lisp; not lisp to eat."     ;yellow-belt
    "Gravitation can not be held responsible for people falling in lisp." ;orenge-belt
    "My lisp didn't please me, so I created my lisp." ;blue-belt
    "Lisp willingly becomes what they wish."          ;indigo-belt
    "What is hell? I maintain that it is the suffering of being unable to lisp." ;violet-belt
    "All roads lead to the lisp."                     ;black-belt
    
    ;; secret-dojo
    ;; http://classics.mit.edu/Tzu/artwar.html, 7.17-19
    ;; http://www.gutenberg.org/ebooks/132
    ;; Let your rapidity be that of the wind, your compactness that of the forest. 
    ;; In raiding and plundering be like fire, is immovability like a mountain. 
    ;; Let your plans be dark and impenetrable as night, and when you move, fall like a thunderbolt. 
    ;; "Master-of-Wind"
    ;; "Master-of-Forest"
    ;; "Master-of-Fire"
    ;; "Master-of-Mountain"
    ;; "Master-of-Shadow"
    ;; "Master-of-Thunder"
    ))

(defun get-promotion-message ()
  (svref *promotion-massage*
         (1+ (floor (get-num-overcame) *promotion-rate*))))

(defparameter *colors*
  #(37  ;white
    31  ;red
    32  ;green
    33  ;yellow
    34  ;blue
    35  ;magenta
    36  ;cyan
    30  ;black
    ))

(defun get-current-belt-color ()
  (svref *colors* (floor (get-num-overcame) *promotion-rate*)))

(defun print-promotion ()
  (format t "[1;~Dm~A[0m~%You get a ~@:(~A~)!~%  ~S"
          (get-current-belt-color) *lisp-road*
          (get-current-belt) (get-promotion-message)))

(defun print-completion ()
  (format t "~2&Congratulations! You finally accomplished all practices!!")
  (princ *completion*))


;;--------------------------------------------------------------------
;; Main
;;--------------------------------------------------------------------

(defun main (command-arguments)
  (destructuring-bind (cmd . args) command-arguments
    (if (string= cmd "progress")
        (output-progress)
        (let ((id (parse-integer (first args))))
          (dispatch-string cmd
            ("check"     (check-solution     id))
            ("problem"   (output-problem   id))
            ("hint"      (output-hint      id))
            ("solutions" (output-solutions id))
            ("reference" (output-reference id))
            ("new"       (make-solution-file id))
            (t
             (error "~S is unknown command" cmd)))))))

(defun in-practice-package (id)
  (let* ((package-name (format nil "LISP-DOJO-~3,'0D" id))
         (package (make-package package-name :use '(:cl))))
    (import '(define-practice =>? <=>? =>error?) package)
    (setf *package* package)))

(defmacro with-in-practice-package (id &body body)
  (with-gensyms (current-package)
    `(let ((,current-package *package*))
       (unwind-protect
            (progn
              (in-practice-package ,id)
              (load-practice ,id)
              ,@body)
         (setf *package* ,current-package)))))

(defun check-solution (id)
  (read-dot-dojo)
  (with-in-practice-package id
    (with-slots (name test-env test-fn) *current-practice*
      (load-solution id name)
      (force test-env)
      ;; Check solution
      (if (not (force test-fn))
          ;; Fail case
          (print-fail-message id name)
          ;; Success case
          (progn
            ;; Update dot dojo
            (overcome-practice id)
            (write-dot-dojo)
            (let ((next-id (1+ id)))
              (when (<= next-id *total-num-practices*)
                (with-in-practice-package next-id
                  (let ((next-name (get-name *current-practice*)))
                    (print-success-message next-id next-name)
                    ;; Make next solution file if does not exist.
                    (unless (probe-file
                             (make-solution-filespec next-id next-name))
                      (make-solution-file next-id))))))
            ;; !! FIXME: once-only print promotion message
            ;; Print promotion message if it is solved first time.
            (when (promotep)
              (print-promotion))
            (when (< *total-num-practices* (get-num-overcame))
              (print-completion))))
      (force-output))))


(defun output-problem (id)
  (with-in-practice-package id
    (with-slots (name level problem) *current-practice*
      (let ((title (generate-practice-title id name level)))
        (format t "
 ~A
 ~A

~A~2%"
                title (make-string (1+ (length title)) :initial-element #\-)
                (strip problem))
        ;; Make solution file if does not exist
        (unless (probe-file (make-solution-filespec id name))
          (princ " ")                   ;indent for generate-message
          (make-solution-file id))
        (format t " Write your solution in ~A~%"
                (make-solution-filespec id name))))
    (force-output)))

(defun output-hint (id)
  (with-in-practice-package id
    (princ (strip (or (get-hint *current-practice*)
                      *under-construction-message*)))
    (force-output)))

(defun output-solutions (id)
  (with-in-practice-package id
    (princ (strip (or (get-solutions *current-practice*)
                      *under-construction-message*)))
    (force-output)))

(defun output-reference (id)
  (with-in-practice-package id
    (princ (strip (or (get-reference *current-practice*)
                      *under-construction-message*)))
    (force-output)))

(defun output-progress ()
  (read-dot-dojo)
  (print-progress)
  (force-output))


;;--------------------------------------------------------------------
;; Run on the Shell
;;--------------------------------------------------------------------
#|

    ~~    o  < Run!!
   ~~ _ \/|> __  
 ~   /   / \   \  ~~
  ~~ \  _\ _\  /   ~~~
 ~~~  \_______/  ~~
   ~~ ~~~   ~~~~~  ~

  The Birth of Venus 

|#

;; Tested: sbcl, clozure, clisp.
;; Not-Tested: gcl, ecl, cmu, allegro, lispworks.
(defun get-command-line-arguments ()

  ;; http://www.sbcl.org/manual/#Command_002dline-arguments
  #+sbcl      (rest sb-ext:*posix-argv*)
  
  ;; http://ccl.clozure.com/manual/chapter2.5.html
  #+clozure   ccl:*unprocessed-command-line-arguments*

  ;; http://www.clisp.org/impnotes/quickstart.html#script-exec
  #+clisp     ext:*args*

  ;; http://cubist.cs.washington.edu/~tanimoto/gcl-si.html#SEC11
  #+gcl       (rest si:*command-args*)

  #+ecl       (loop :for i :from 1 :below (si:argc) :collect (si:argv i))
  
  ;; http://common-lisp.net/project/cmucl/doc/cmu-user/unix.html
  #+cmu       (rest extensions:*command-line-words*)
  
  ;; http://www.franz.com/support/documentation/9.0/doc/operators/system/command-line-arguments.htm
  #+allegro   (rest (sys:command-line-arguments))

  ;; http://www.lispworks.com/documentation/lw61/LW/html/lw-1398.htm#36091
  #+lispworks (rest sys:*line-arguments-list*)
  
  #-(or sbcl clozure gcl ecl cmu allegro lispworks clisp)
  (error "Sorry, not supported for your CL implementation.~
          Current supported CL implementations are:
           sbcl, clozure, clisp, gcl, ecl, cmu, allegro, lispworks.")
  )


;; for DBG
;; (main (get-command-line-arguments))

(handler-case
    (main (get-command-line-arguments))
  (error (c) (format t "Unexpected error [~S]" (type-of c))))


#+clozure (ccl:quit)

;;====================================================================
