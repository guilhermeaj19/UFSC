(defun maior (a b c)
    (cond
        ((and (>= a b) (>= a c)) a)
        ((and (>= b a) (>= b c)) b)
        (t c)
    )
)
(defun main ()
    (write-line (write-to-string (maior 10 5 2)))
    (write-line (write-to-string (maior 1 9 2)))
    (write-line (write-to-string (maior 4 1 142)))
)
(main)