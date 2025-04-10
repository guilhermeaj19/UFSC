(define (combine3 n set rest)
  (letrec
    ((tails-of
       (lambda (set)
         (cond ((null? set)
                 '())
               (else
                 (cons set (tails-of (cdr set)))))))
     (combinations
       (lambda (n set)
         (cond
           ((zero? n)
             '())
           ((= 1 n)
             (map list set))
           (else
             (apply append
                    (map (lambda (tail)
                           (map (lambda (sub)
                                  (cons (car tail) sub))
                                (combinations (- n 1) (rest tail))))
                         (tails-of set))))))))
    (combinations n set)))

;; create k-combination without repetion
(define (combine n set)
  (combine3 n set cdr))

;; create k-combination with repetition
(define (combine* n set)
  (combine3 n set (lambda (x) x)))

(define (main)
  (write (combine 2 '("a" "b" "c")))
)
(main)