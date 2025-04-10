(define (ocorrencias list_int num)
    (cond
        ((null? list_int) 0)
        ((= (car list_int) num) (+ 1 (ocorrencias (cdr list_int) num)))
        (else (ocorrencias (cdr list_int) num))
)
)


(define (main)
    (display (ocorrencias '(10 5 3 -9 1 5) 5)) (newline)
    (display (ocorrencias '(10 5 3 -9 1 5) 12)) (newline)
)
(main)