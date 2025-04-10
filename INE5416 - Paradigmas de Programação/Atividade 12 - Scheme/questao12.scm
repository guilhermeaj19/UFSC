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

(define (apagar index list_int)
    (cond
        ((>= index (length list_int)) "Index Range Error")
        (else (append (fatia list_int 0 index) (fatia list_int (+ index 1) (length list_int))))
    )
)
(define (main)
    (display (apagar 5 '(5 4 3 2 1 2 3 3)))
)
(main)