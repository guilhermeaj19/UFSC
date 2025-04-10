ocorrencias :: [Int] -> Int -> Int
ocorrencias [] _ = 0
ocorrencias (a:b) valor | a == valor = 1 + ocorrencias b valor
                        | otherwise = ocorrencias b valor

main :: IO ()
main = do
    let lista1 = [123,52,6,192,1239012,53]
    let lista2 = [5, 5, 1, 5, 5, 4, 2, 3]
    print lista1
    print (filter (> 50) lista1)
    print (ocorrencias lista1 6)
    print lista2
    print (ocorrencias lista2 5)