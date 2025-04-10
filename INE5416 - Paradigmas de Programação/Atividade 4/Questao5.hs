
aprovacao :: Float -> Float -> Float -> String
aprovacao notaA notaB notaC =
    if (notaA + notaB + notaC)/3 < 6 then
        "Reprovado"
    else
        "Aprovado"

main = do
    putStrLn "Nota A do Aluno: "
    notaAStr <- getLine
    putStrLn "Nota B do Aluno: "
    notaBStr <- getLine
    putStrLn "Nota C do Aluno: "
    notaCStr <- getLine
    let notaA = (read notaAStr :: Float)
    let notaB = (read notaBStr :: Float)
    let notaC = (read notaCStr :: Float)
    print("Status: " ++ aprovacao notaA notaB notaC)

