Last modified: 2013-10-15 19:02:54 tkych

Version: 0.0.34 (alpha)


Lisp-Dojo: Lisp Training Hall
=============================

> the most effective learning requires a well-defined task with
> an appropriate difficulty level for the particular individual,
> informative feedback, and opportunities for repetition and corrections of errors.

> --- [Jean Lave, Cognition in Practice, p. 20-21](http://www.amazon.com/exec/obidos/ASIN/0521357349)
> quoted by [Peter Norvig, Teach Yourself Programming in Ten Years](http://www.norvig.com/21-days.html)


> In most fields the appearance of ease seems to come with practice.
> Perhaps what practice does is train your unconscious mind to handle
> tasks that used to require conscious thought.
> ...
> When people talk about being in "the zone," I think what they mean is
> that the spinal cord has the situation under control. Your spinal cord
> is less hesitant, and it frees conscious thought for the hard problems.

> --- [Paul Graham, Taste for Makers][pg]


Introduction
------------

[Dojo (道場)][dojo] is a training hall to learning morality and martial arts (e.g. Karate, Judo, Ninja, etc.) in Japan.
Lisp-Dojo is a training hall for the practice of Common Lisp (to make functions, data-stractures and macros).

We suppose that you already have a knowledge of Common Lisp basics (syntax, built-in functions and data-types, etc.).
If you want first to learn/review Common Lisp basics, the following excellent resources are abailable on the web.

 - [Common Lisp Quick Reference][clqr] by Bert Burgemeister
 - [Common Lisp: A Gentle Introduction to Symbolic Computation][gentle] by David S. Touretzky
 - [Practical Common Lisp][pcl] by Peter Seibel
 - [Lisp-Koans][lisp-koans] by Google Inc.

For more links about Common Lisp for newcomers are found in [here][wellcome].


[pg]: http://www.paulgraham.com/taste.html
[dojo]: http://en.wikipedia.org/wiki/Dojo
[clqr]: http://clqr.boundp.org/
[gentle]: http://www-cgi.cs.cmu.edu/afs/cs.cmu.edu/user/dst/www/LispBook/index.html
[pcl]: http://www.gigamonkeys.com/book/
[lisp-koans]: https://github.com/google/lisp-koans
[wellcome]: https://github.com/tkych/lisp-dojo/blob/master/wellcome-to-cl.md


Usage
-----

`$` is a command prompt.


    $ ./lisp-dojo --help


~~~~ print usage message ~~~~


    $ ./lisp-dojo problem 0

     0. HELLO
     ---------

     HELLO => greeting-string

       Make function HELLO.
       It takes no arguments, and returns "Wellcome to the Lisp Dojo!".

     Example:

       (hello) => "Wellcome to the Lisp Dojo!"

     New answer file generated: your-solutions/000-hello.lisp
     Write your solution in your-solutions/000-hello.lisp


    $ ./lisp-dojo check 0
    FAIL ... (hello) =>? "Wellcome to the Lisp Dojo!" ... => UNDEFINED-FUNCTION-CALL
    Some Tests Failed --- Try again this practice in your-solutions/000-hello.lisp


 ~~~~ edit your-solutions/000-hello.lisp ~~~~
 e.g. `(defun hello () 'Wellcome-to-the-Lisp-Dojo!)`


    $ ./lisp-dojo check 0
    FAIL ... (hello) =>? "Wellcome to the Lisp Dojo!" ... => WELLCOME-TO-THE-LISP-DOJO!
    Some Tests Failed --- Try again this practice in your-solutions/000-hello.lisp

    $ ./lisp-dojo hint 0
    No arguments, return string.


 ~~~~ edit your-solutions/000-hello.lisp ~~~~
 e.g. `(defun hello () "Wellcome to the Lisp Dojo!")`


    $ ./lisp-dojo check 0
    PASS ... (hello) => "Wellcome to the Lisp Dojo!"
    All Tests Passed -- Challenge next practice in answers/001-hello.lisp


~~~~ print succsess message ~~~~


    $ ./lisp-dojo solutions 0
     (defun hello () "Wellcome to the Lisp Dojo!")


Note
----

 - Documemtations is not compleate.
 - The solutions are just some solutions of many solutions.
 - The check is not perfect. e.g. the function defined by the following anwser is also pass the check.

```
      (defun hello (&optional foo)
        (unnecessary-computation foo)
        "Wellcome to the Lisp Dojo!")
```

 - If no return, probably infinit-loop occurs.
 - using REPL.
 - Initialization: remove all files in lisp-dojo/your-solutions, change the number in .dojo to 0.


Reference
---------

 - [L-99](http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html)
 - [SICP](http://mitpress.mit.edu/sicp/full-text/book/book.html)
 - [On Lisp](http://www.paulgraham.com/onlisp.html)
 - [M.Hiroi's Home Page: Common Lisp Programming (Japanese)](http://www.geocities.jp/m_hiroi/clisp/index.html)


Author, License, Copyright
--------------------------

 - Takaya OCHIAI  <#.(reverse "moc.liamg@lper.hcykt")>

 - The MIT License (lisp-dojo/lisp-dojo, lisp-dojo/core.lisp)

 - Copyright (C) 2013 Takaya OCHIAI

 - The Public Domain (all files in lisp-dojo/practices/)
