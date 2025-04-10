(define (apagarEnquanto f list_int)
    (cond 
        ((null? list_int) '())
        ((f (car list_int)) (apagarEnquanto f (cdr list_int)))
        (else list_int)
    )
)

(define (main)
    (display (apagarEnquanto even? '(2 8 4 9 3 2 5)))
)
(main)