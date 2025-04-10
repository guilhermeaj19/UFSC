(define (enesimo list_int n)
    (cond
        ((or (null? list_int) (< n 0)) '())
        (else (buscaPosicao list_int 0 n))
    )
)

(define (buscaPosicao list_int idx n)
    (cond
        ((null? list_int) '())
        ((= idx n) (car list_int))
        (else (buscaPosicao (cdr list_int) (+ idx 1) n))
    )
)

(define (main)
    (display (enesimo '(5 3 2 4 1 9 12) 5)) (newline)
    (display (enesimo '(5 3 2 4 1 9 12) 0)) (newline)
    (display (enesimo '(5 3 2 4 1 9 12) -5)) (newline)
    (display (enesimo '(5 3 2 4 1 9 12) 124)) (newline)
    
)
(main)