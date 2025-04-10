
;;Função que retorna uma string com o conteúdo do arquivo filename lido
(define (readlines filename)
  (call-with-input-file filename
    (lambda (p)
      (let loop ((line (read-line p))
                 (result '()))
        (if (eof-object? line)
            (reverse result)
            (loop (read-line p) (cons line result))))))
)

;;Função que retorna uma lista com as strings separadas a partir de um delimitador ("char-delimiter")
;;Por exemplo: char-whitespace? fará o split nos caracteres em branco
(define (string-split char-delimiter? string)
  (define (maybe-add a b parts)
    (if (= a b) parts (cons (substring string a b) parts)))
  (let ((n (string-length string)))
    (let loop ((a 0) (b 0) (parts '()))
      (if (< b n)
          (if (not (char-delimiter? (string-ref string b)))
              (loop a (+ b 1) parts)
              (loop (+ b 1) (+ b 1) (maybe-add a b parts)))
          (reverse (maybe-add a b parts)))))
)

;;Função auxiliar para slice
(define addToList
    (lambda (a b) 
        (cond ((null? a) (list b)) ; result needs to be a list
              ((null? b) a)
              ((cons (car a) (addToList (cdr a) b)))
        )
    )
)

;;Função que retorna um parte da lista de offset até n
(define (slice lista offset n)
    (define i offset)
    (define list_return '())
    (do ()
        ((= i n))
        (set! list_return (addToList list_return (list-ref lista i)))
        (set! i (+ i 1))
    )
    list_return
)

;;Mapeamento que recebe um argumento de entrada junto com a função.
;;Esse argumento nesse caso é a verificação char-whitespace? para fazer a separação da string recebida do arquivo
(define (my-map f arg list)
    (cond
        ((null? list) '())
        (else (cons (f arg (car list)) (my-map f arg (cdr list))))
    )
)