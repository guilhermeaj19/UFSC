(define (alunos)
    '((1 "Bob" (5.6 8 9.3))
      (2 "Ana" (8.2 9 7 6.5))
      (3 "Tom" (3.2 7 5.7 8.3))
      (4 "Bin" (7.5 5.3 8.5 6.2 3.1))
      (5 "Bia" (6.7 4.1 5.5)))
)

(define (getNome aluno)
    (car (cdr aluno))
)

(define (getNomes lista)
    (cond
        ((null? lista) '())
        (else (cons (getNome (car lista)) (getNomes (cdr lista))))
    )
)

(define (soma list_float)
    (cond
        ((null? list_float) 0)
        (else (+ (car list_float) (soma (cdr list_float))))
    )
)

(define (calculaMedia list_float)
    (cond
        ((null? list_float) 0)
        (else (/ (soma list_float) (length list_float)))
    )
)

(define (getNotas aluno)
    (list-ref aluno 2)
)

(define (medias lista_alunos)
    (cond
        ((null? lista_alunos) '())
        (else (cons '((getNome (car lista_alunos)) 
                      (calculaMedia (getNotas (car lista_alunos))))
                     (medias (cdr lista_alunos))))
    )
)

(define (mediaTurma lista_alunos)
    (calculaMedia (medias lista_alunos))
)

(define (main)
    (display (medias (alunos))) (newline)
    (display (mediaTurma (alunos))) (newline)
)
(main)