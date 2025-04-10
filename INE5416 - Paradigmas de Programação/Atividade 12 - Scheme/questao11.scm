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

(define (primeiros n list_int)
    (cond
        ((> n (length list_int)) list_int)
        (else (fatia list_int 0 n))
    )
)

(define (main)
    (display (primeiros 5 '(5 3 2 1 2 0 9 4))) (newline)
    (display (primeiros 12 '(5 3 2 1 2 0 9 4))) (newline)
)
(main)