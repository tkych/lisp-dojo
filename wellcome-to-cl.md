Last modified: 2013-10-13 00:25:03 tkych


Wellcome to the Common Lisp: Links for Newcomers
================================================

Links are not perfect.


Introduction
------------

 - [CLiki: Getting Started](http://www.cliki.net/Getting%20Started)
 - [Nikodemus' Common Lisp FAQ](http://random-state.net/files/nikodemus-cl-faq.html)
 - [articulate-lisp](http://articulate-lisp.com/index.html)


Setup Environment (emacs, quicklisp, slime)
-------------------------------------------

 0. see [Installing Common Lisp, Emacs, Slime & Quicklisp](http://www.youtube.com/watch?v=VnWVu8VVDbI) (for windows)
 1. install one of common lisp implementations
    - [sbcl](http://www.sbcl.org/)
    - [clozure](http://www.clozure.com/index.html)
    - [clisp](http://www.clisp.org/)
    - etc.
 2. install [emacs](http://www.emacswiki.org/)
 3. install [quicklisp](http://www.quicklisp.org/)
    1. get slime-helpaer [slime](http://common-lisp.net/project/slime/) (quickloadable)
    2. get clhs (quickloadable)
 4. install useful emacs mode (optional)
    - [auto-complete-mode](https://github.com/auto-complete/auto-complete),
    - [paredit-mode](http://www.emacswiki.org/emacs/ParEdit),
    - [rainbow-mode](http://www.emacswiki.org/emacs/).
 5. start happy hacking.


Practice Tips
-------------

 - Let's print out [Common Lisp Quick Reference](http://clqr.boundp.org/)

 - Useful Functions for development & debugging
   - [print](http://www.lispworks.com/documentation/HyperSpec/Body/f_wr_pr.htm)
   - [step](http://www.lispworks.com/documentation/HyperSpec/Body/m_step.htm)
   - [trace](http://www.lispworks.com/documentation/HyperSpec/Body/m_tracec.htm)
   - [break](http://www.lispworks.com/documentation/HyperSpec/Body/f_break.htm)
   - [describe](http://www.lispworks.com/documentation/HyperSpec/Body/f_descri.htm)
   - [apropos](http://www.lispworks.com/documentation/HyperSpec/Body/f_apropo.htm)
   - [time](http://www.lispworks.com/documentation/HyperSpec/Body/m_time.htm)
   - [room](http://www.lispworks.com/documentation/HyperSpec/Body/f_room.htm)
   - [disassemble](http://www.lispworks.com/documentation/HyperSpec/Body/f_disass.htm)

 - Style Guide
   - [Google Common Lisp Style Guide](http://google-styleguide.googlecode.com/svn/trunk/lispguide.xml)
     - [Chinease translation](http://gclsg.lisp.tw/)
     - [Japanese translation](http://google-common-lisp-style-guide-ja.cddddr.org/)
   - [Tutorial on Good Lisp Programming Style, by Peter Norvig and Kent Pitman](http://norvig.com/luv-slides.ps)
     - [pdf](http://www.cs.umd.edu/~nau/cmsc421/norvig-lisp-style.pdf)
   - [Lisp Style Tips for the Beginner by Heinrich Taube](http://people.ace.ed.ac.uk/staff/medward2/class/moz/cm/doc/contrib/lispstyle.html)
   - [Naming Conventions](http://www.cliki.net/naming%20conventions)

 - Search-Answer/Post-Question
   - [reddit/lisp](http://www.reddit.com/r/lisp/)
   - [stack overflow/common-lisp](http://stackoverflow.com/questions/tagged/common-lisp)

 - See source code of high quality utilities (e.g. alexandria) on [quickutil](http://quickutil.org/)

 - Search-library
   - `(ql:system-apropos "foo")`
   - [quickdocs](http://quickdocs.org/)
   - [quicksearch](http://github.com/tkych/quicksearch)
   - [Cliki](http://cliki.net/)
   - [GitHub: Common Lisp](https://github.com/languages/Common%20Lisp)
   - [BitBucket: Common Lisp](https://bitbucket.org/repo/all?name=common+lisp)

 - Read specification [Common Lisp HyperSpec](http://www.lispworks.com/documentation/HyperSpec/Front/index.htm)

 - Run program as shell script
   - [sbcl](http://www.sbcl.org/manual/#Shebang-Scripts)
   - [quicklisp](http://stackoverflow.com/questions/9229526/how-to-use-quicklisp-when-cl-program-is-invoked-as-a-shell-script)

 - Make Executable
   - [buildapp](http://www.xach.com/lisp/buildapp/)

 - Introduction to the Recursion
   - [Common Lisp: A Gentle Introduction to Symbolic Computation: 8 Recursion, p.231-](http://www-cgi.cs.cmu.edu/afs/cs.cmu.edu/user/dst/www/LispBook/index.html) by David S. Touretzky

 - Tips
   - [Common Lisp Tips](http://lisptips.com/)
   - [Slime Tips](http://slime-tips.tumblr.com/)


Community
---------

 - [Cliki](http://cliki.net/)
 - [Planet Lisp](http://planet.lisp.org/)
 - [Common Lisp.net](http://common-lisp.net/)
 - [Lisp In Summer Projects](http://lispinsummerprojects.org/)
 - Local Community (alphabetical order)
   - America
     - [Lisp Meetings Calendar](http://planet.lisp.org/meetings/)
   - Japan
     - [LispHub.jp](http://lisphub.jp/)
     - [Common LISP users jp](http://cl.cddddr.org/)
     - [raddit/lisp_ja](http://www.reddit.com/r/lisp_ja/)
     - [逆引きCommon Lisp](http://tips.lisp-users.org/common-lisp/)
     - [format関数](http://super.para.media.kyoto-u.ac.jp/~tasuku/format-func.html)
   - Republic of China
     - [Lisp Taiwan](http://lisp.tw/)
   - Russia
     - [Russian Lisp Planet](http://lisper.ru/planet/)


Books
-----

- Beginner
  - [Land of Lisp](http://landoflisp.com/)
    - [Casting Spels in Lisp](http://www.lisperati.com/casting.html)
  - [Common Lisp: A Gentle Introduction to Symbolic Computation](http://www.cs.cmu.edu/~dst/LispBook/)

- Basic 
  - [Practical Common Lisp](http://www.gigamonkeys.com/book/)
  - [ANSI Common Lisp](http://www.paulgraham.com/acl.html)

- Advanced
  - [PAIP: Paradigms of AI Programming](http://norvig.com/paip.html)
  - [CLTL2: Common Lisp The Language 2nd. ed.](http://www.cs.cmu.edu/afs/cs.cmu.edu/project/ai-repository/ai/html/cltl/cltl2.html)

- Speciphic Topics
  - Macros
     - [On Lisp](http://www.paulgraham.com/onlisp.html)
     - [Let Over Lambda](http://letoverlambda.com/)
  - CLOS
     - Object-Oriented Programming in COMMON LISP
     - [The Art of the Metaobject Protocol](http://www.lisp.org/mop/)
  - Web Programming
     - [Lisp web tails](http://lispwebtales.ppenev.com/)

- Programming General
  - [SICP: Structure and Interpretaion of Computer Program](http://www.cliki.net/SICP) (scheme)

