(define (soma list_int)
    (cond
        ((null? list_int) 0)
        (else (+ (car list_int) (soma (cdr list_int))))
    )
)

(define (media list_int)
    (cond
        ((null? list_int) 0)
        (else (/ (soma list_int) (length list_int)))
    )
)
(define (main)
    (display (media '(5 3 1 2 5)))
)
(main)