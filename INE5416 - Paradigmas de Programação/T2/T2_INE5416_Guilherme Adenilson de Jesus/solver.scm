(include "readfile.scm")

;;Por padrão, o board sempre começa zerado
(define board_puzzle 
    (vector (vector 0 0 0 0 0 0 0 0 0)
            (vector 0 0 0 0 0 0 0 0 0)
            (vector 0 0 0 0 0 0 0 0 0)
            (vector 0 0 0 0 0 0 0 0 0)
            (vector 0 0 0 0 0 0 0 0 0)
            (vector 0 0 0 0 0 0 0 0 0)
            (vector 0 0 0 0 0 0 0 0 0)
            (vector 0 0 0 0 0 0 0 0 0)
            (vector 0 0 0 0 0 0 0 0 0))
)

;;Retorna uma lista com os elementos da linha referente
(define (getRow board row)
    (vector-ref board row)
)

;;Retorna uma lista com os elementos da coluna referente
(define (getColumn board col)
    (let ((len (vector-length board)))
        (let loop ((i 0) (result (make-vector len)))
            (cond
                ((= i len) result)
                (else (begin
                        (vector-set! result i (getCell board i col))
                        (loop (+ i 1) result)
                ))
            )
        )
    )
)

;;Retorna uma lista com o quadrado que a posição [row][col] está inserida
(define (getSquare board row col)
    (let* ((startRow (- row (modulo row 3)))
           (startCol (- col (modulo col 3)))
           (square (make-vector 0))
           (i 0)
           (j 0))
        (do ((i 0 (+ i 1))) ((= i 3) square)
            (do ((j 0 (+ j 1))) ((= j 3))
                (set! square (vector-append square (vector (getCell board (+ startRow i) (+ startCol j)))))
            )
        )
    )
)

;;Retorna o valor em matrix[row][col]
(define (getCell matrix row col)
    (vector-ref (vector-ref matrix row) col)
)

;;Retorna o comparador na posição [row][col]
(define (getComp list_comp row col)
    (list-ref (list-ref list_comp row) col)
)

;;Verifica se um elemento está na lista
(define (isElem vec k)
    (let ((len (vector-length vec)))
        (let loop ((i 0))
            (cond
                ((= i len) #f)
                ((= (vector-ref vec i) k) #t)
                (else (loop (+ i 1)))
            )
        )
    )
)

;;Compara se um número é maior/menor que outro
(define (comparing a comp b)
    (cond
        ((and (= a 1) (string=? comp ">")) #f) ;;1 nunca será maior que qualquer outro número
        ((and (= a 9) (string=? comp "<")) #f) ;;9 nunca será menor que qualquer outro número
        ((and (= b 1) (string=? comp "<")) #f) ;;1 nunca será maior que qualquer outro número
        ((and (= b 9) (string=? comp ">")) #f) ;;9 nunca será menor que qualquer outro número
        ((or  (= a 0) (= b 0)) #t) ;;Se alguns deles for zero, então pode inserir sempre
        ((string=? comp ">") (> a b))
        (else (< a b))
    )
)

;;Verifica se o número sugerido é possível
(define (isPossible board row col num comp_h comp_v)
    (cond
        ;;Verificações padrões do sudoku
        ((> (getCell board row col) 0) #f)
        ((isElem (getRow board row) num) #f)
        ((isElem (getColumn board col) num) #f)
        ((isElem (getSquare board row col) num) #f)

        ;;Verificação dos comparadores, referente a posição relativa ao quadrado que [row][col] está
        ((and ( = (modulo row 3) 0) ( = (modulo col 3) 0)) (and (comparing  num                          (getComp comp_h row col)      (getCell board row (+ col 1)))
                                                                (comparing  num                          (getComp comp_v row col)      (getCell board (+ row 1) col)))
        )

        ((and ( = (modulo row 3) 0) ( = (modulo col 3) 1)) (and (comparing (getCell board row (- col 1)) (getComp comp_h row (- col 1)) num )
                                                                (comparing  num                          (getComp comp_v row col)      (getCell board row (+ col 1)))
                                                                (comparing  num                          (getComp comp_h row col)      (getCell board (+ row 1) col)))
        )
        ((and ( = (modulo row 3) 0) ( = (modulo col 3) 2)) (and (comparing (getCell board row (- col 1)) (getComp comp_h row (- col 1)) num )
                                                                (comparing  num                          (getComp comp_h row col)      (getCell board (+ row 1) col)))
        )
        ((and ( = (modulo row 3) 1) ( = (modulo col 3) 0)) (and (comparing  num                          (getComp comp_h row col)      (getCell board row (+ col 1)))
                                                                (comparing  num                          (getComp comp_v row col)      (getCell board (+ row 1) col))
                                                                (comparing (getCell board (- row 1) col) (getComp comp_v (- row 1) col) num))
        )
        ((and ( = (modulo row 3) 1) ( = (modulo col 3) 1)) (and (comparing  num                          (getComp comp_h row col)      (getCell board row (+ col 1)))
                                                                (comparing  num                          (getComp comp_v row col)      (getCell board (+ row 1) col))
                                                                (comparing (getCell board (- row 1) col) (getComp comp_v (- row 1) col) num)
                                                                (comparing (getCell board row (- col 1)) (getComp comp_h row (- col 1)) num))
        )
        ((and ( = (modulo row 3) 1) ( = (modulo col 3) 2)) (and (comparing  num                          (getComp comp_v row col)      (getCell board (+ row 1) col))
                                                                (comparing (getCell board (- row 1) col) (getComp comp_v (- row 1) col) num)
                                                                (comparing (getCell board row (- col 1)) (getComp comp_h row (- col 1)) num))
        )
        ((and ( = (modulo row 3) 2) ( = (modulo col 3) 0)) (and (comparing  num                          (getComp comp_h row col)      (getCell board row (+ col 1)))
                                                                (comparing (getCell board (- row 1) col) (getComp comp_v (- row 1) col) num))
        )
        ((and ( = (modulo row 3) 2) ( = (modulo col 3) 1)) (and (comparing  num                          (getComp comp_h row col)      (getCell board row (+ col 1)))
                                                                (comparing (getCell board (- row 1) col) (getComp comp_v (- row 1) col) num)
                                                                (comparing (getCell board row (- col 1)) (getComp comp_h row (- col 1)) num))
        )
        (else                                              (and (comparing (getCell board (- row 1) col) (getComp comp_v (- row 1) col) num)
                                                                (comparing (getCell board row (- col 1)) (getComp comp_h row (- col 1)) num))
        )
    )
)

;;Imprime o board no terminal
(define (print-board board)
    (define i 0)
    (do ()
        ((= i 9))
        (display (vector-ref board i))
        (newline)
        (set! i (+ i 1))
    )
)

;;Função que realiza o backtracking
(define (solve board row col comp_h comp_v)
  (if (and (= row (- 9 1)) (= col 9)) ;;Verifica se concluiu o backtracking
      ;;Se concluiu, imprime a solução e fecha o programa
      (begin
        (print-board board)
        (exit)) 
      ;;Se não, continua para a próxima posição a ser testada
      (begin
        ;;Atualiza o valor de row se chegar no fim do vetor
        (if (= col 9)
            (begin
              (set! row (+ row 1))
              (set! col 0)))
        ;;Verifica se a posição já tem um valor colocado
        (if (> (vector-ref (vector-ref board row) col) 0)
            (solve board row (+ col 1) comp_h comp_v)
            (begin
              (do ((num 1 (+ num 1))) ((> num 9) #f)
                (if (isPossible board row col num comp_h comp_v) ;;Verifica se a opção de valor é possível
                    (begin
                      (vector-set! (vector-ref board row) col num)
                      (if (solve board row (+ col 1) comp_h comp_v) ;;Verifica se o backtracking foi sucedido
                          #t
                          (vector-set! (vector-ref board row) col 0)
                      )
                    )
                )
               )
            )
        )
      )
  )
)

(define (main)
    (display "Digite o arquivo do puzzle a ser resolvido: ")
    (let ((x (read-line)))
        (define compH (my-map string-split char-whitespace? (slice (readlines x) 0 9))) ;;Comparadores Horizontais
        (define compV (my-map string-split char-whitespace? (slice (readlines x) 10 19))) ;;Comparadores Verticais
        (display "Resolvendo... ") (newline)
        (solve board_puzzle 0 0 compH compV)
        (display "Solucao nao encontrada")
    )
)
(main)