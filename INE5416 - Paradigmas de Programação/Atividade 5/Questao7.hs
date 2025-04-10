
alunos :: [(Int, String, Float)]
alunos = [(1, "Ana", 3.4), (2, "Bob", 6.7), (3, "Tom", 7.6)]

getNome :: (Int, String, Float) -> String
getNome (a,b,c) = b

getNota :: (Int, String, Float) -> Float
getNota (pos, nome, nota) = nota

getPrimeiroAluno :: [(Int, String, Float)] -> (Int, String, Float)
getPrimeiroAluno (a:_) = a

gerarPares :: [t] -> [u] -> [(t,u)] 
gerarPares l1 l2 = [(a,b) | a <- l1, b <- l2]

listarNomes :: [(Int, String, Float)] -> [String]
listarNomes listaAlunos = map getNome listaAlunos

aprovados :: [(Int, String, Float)] -> [String]
aprovados listaAlunos = listarNomes (filter (\n -> getNota n >= 6) alunos)

aprovados2 :: [(Int, String, Float)] -> [String]
aprovados2 [] = []
aprovados2 (a:b) | getNota a >= 6 = getNome a : aprovados2 b
                 | otherwise = aprovados2 b

main = do
    print (aprovados alunos)
    print (aprovados2 alunos)