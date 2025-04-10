(define (maximoDivisor x y)
    (cond
        ((= y 0) x)
        ((= x 0) y)
        ((> x y) (maximoDivisor (modulo x y) y))
        (else (maximoDivisor x (modulo y x)))
    )
)

(define (minimoMulti x y)
    (/ (* x y) (maximoDivisor x y)))

(define (main)
    (write (minimoMulti 12 94)) 
)
(main)