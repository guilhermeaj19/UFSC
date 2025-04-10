(defun triangle (base altura)
    (/ (* base altura) 2)
)

(defun main ()
    (write-line (write-to-string (triangle 5 10)))
)
(main)