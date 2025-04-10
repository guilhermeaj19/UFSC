busca :: [Int] -> Int -> Bool
busca [] _ = False
busca (a:b) valorDeBusca | a /= valorDeBusca = busca b valorDeBusca
                         | a == valorDeBusca = True
                         | otherwise = False

main :: IO ()
main = do
    let lista = [123,52,6,192,1239012,53]
    print lista
    print (busca lista 192)
    print (busca lista 193)