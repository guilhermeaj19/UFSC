(defun media (a b c)
    (cond
        ((>= (/ (+ a b c) 3) 6) "Aprovado")
        (t "Reprovado")
    )
)
(defun main ()
    (write-line (write-to-string (media 5 10 5)))
    (write-line (write-to-string (media 5 3 5)))
)
(main)