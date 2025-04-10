(define (isDivisivel x y)
    (= (modulo x y) 0)
)

(define (main)
    (display (isDivisivel 5 3))
    (display (isDivisivel 10 5))
)
(main)