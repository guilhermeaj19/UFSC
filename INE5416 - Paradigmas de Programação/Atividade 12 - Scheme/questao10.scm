(define (mapear f list_int)
    (cond
        ((null? list_int) '())
        (else (cons (f (car list_int)) (mapear f (cdr list_int))))    
    )
)

(define (main)
    (display (mapear odd? '(5 4 3 2 1 2 6 4))) (newline)

)
(main)