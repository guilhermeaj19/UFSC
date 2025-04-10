(define (busca list_int num)
    (cond
        ((null? list_int) #f)
        ((= (car list_int) num) #t)
        (else (busca (cdr list_int) num))
)
)


(define (main)
    (display (busca '(10 5 3 -9 1 5) 5)) (newline)
    (display (busca '(10 5 3 -9 1 5) 12)) (newline)
)
(main)