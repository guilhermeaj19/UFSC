(defun fibonacci (n)
    (cond
        ((= n 0) 0)
        ((= n 1) 1)
        (t (+ (fibonacci (- n 2)) (fibonacci (- n 1))))
    )
)
(defun main ()
    (write-line (write-to-string (fibonacci 10)))
    (write-line (write-to-string (fibonacci 14)))
)
(main)