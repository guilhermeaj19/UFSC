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

(define (fatia list_int n m)
    (cond
        ((or (< (length list_int) m) (< (length list_int) n)) "Index Range Error")
        ((>= n m) '())
        (else (cons (enesimo list_int n) (fatia list_int (+ n 1) m)))
    )
)

(define (inverte list_int)
    (cond
        ((null? list_int) '())
        (else (cons (enesimo list_int (- (length list_int) 1)) (inverte (fatia list_int 0 (- (length list_int) 1)))))
    )
)
(define (main)
    (display (inverte '(5 4 3 2 1 5 6 7 8 8 2 1 2)))
)
(main)