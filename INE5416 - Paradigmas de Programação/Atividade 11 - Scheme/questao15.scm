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

(define (numCoprimos n r)
    (cond
        ((and (>= r 1) (isCoprimo n r)) (+ 1 (numCoprimos n (- r 1))))
        ((>= r 1) (numCoprimos n (- r 1)))
        (else 0)
    )
)

(define (totienteEuler n)
    (numCoprimos n (- n 1))
)

(define (main)
    (display (totienteEuler 10)) (newline)
)
(main)