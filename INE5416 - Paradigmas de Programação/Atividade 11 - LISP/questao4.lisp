(defun xor (a b)
    (or (and a (not b)) (and (not a) b))
)
(defun main ()
    (write-line (write-to-string (xor T NIL)))
    (write-line (write-to-string (xor T T)))
    (write-line (write-to-string (xor NIL NIL)))
    (write-line (write-to-string (xor NIL T)))
)
(main)