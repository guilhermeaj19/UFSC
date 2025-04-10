(defun absolut (x)
    (cond
        ((< x 0) (* -1 x))
        (t x)
    )
)

(defun main()
    (write-line (write-to-string (absolut -5)))
    (write-line (write-to-string (absolut 0)))
    (write-line (write-to-string (absolut 124)))
)
(main)