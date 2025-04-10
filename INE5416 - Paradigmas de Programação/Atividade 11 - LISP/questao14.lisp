(defun maximoDivisor (x y)
    (cond
        ((= y 0) x)
        ((= x 0) y)
        ((> x y) (maximoDivisor (mod x y) y))
        (t (maximoDivisor x (mod y x)))
    )
)

(defun isCoprimo (x y)
    (cond
        ((= (maximoDivisor x y) 1) T)
        (t NIL)
    )
)

(defun main ()
    (write-line (write-to-string (isCoprimo 12 94)))
    (write-line (write-to-string (isCoprimo 12 97)))
)
(main)