(define (maximoDivisor x y)
    (cond
        ((= y 0) x)
        ((= x 0) y)
        ((> x y) (maximoDivisor (modulo x y) y))
        (else (maximoDivisor x (modulo y x)))
    )
)
(define (isCoprimo x y)
    (cond
        ((= (maximoDivisor x y) 1) #t)
        (else #f)
    )
)

(define (main)
    (display (isCoprimo 12 94)) (newline)
    (display (isCoprimo 12 97))
)
(main)