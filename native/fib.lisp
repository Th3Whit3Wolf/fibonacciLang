(declaim (optimize (speed 3) (debug 0) (safety 0)))
(declaim (ftype    (function (fixnum) fixnum) fib))
(defun fibLisp (n)
  (if (<= n 2)
      1
      (+ (fibLisp (1- n))
         (fibLisp (- n 2)))))

(defun main ()
  (write (fibLisp 40)))

#+sbcl
(sb-ext:save-lisp-and-die "fibLisp" :toplevel #'main :executable t)

#+ccl
(ccl:save-application "fibLisp" :toplevel-function #'main :prepend-kernel t)