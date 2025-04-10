(define (isDivisivel x y)
    (= (modulo x y) 0)
)

(define (isPrimo n)
    (= (countDivisores n 1) 2)
)

(define (countDivisores n d)
    (cond
        ((= n d) 1)
        ((isDivisivel n d) (+ 1 (countDivisores n (+ d 1))))
        (else (countDivisores n (+ d 1)))
    )
)

(define (main)
    (display (isPrimo 15)) (newline)
    (display (isPrimo 7)) (newline)
    (display (isPrimo 653)) (newline)
)
(main)