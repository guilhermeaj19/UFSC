(defun maximoDivisor (x y)
    (cond
        ((= y 0) x)
        ((= x 0) y)
        ((> x y) (maximoDivisor (mod x y) y))
        (t (maximoDivisor x (mod y x)))
    )
)

(defun minimoMulti (x y)
    (/ (* x y) (maximoDivisor x y)))

(defun main ()
    (write-line (write-to-string (minimoMulti 12 94)))  
)
(main)