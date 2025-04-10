
soma :: [Int] -> Int
soma [] = 0
soma (a:b) = a + soma b

main :: IO ()
main = do
    let lista = [0,2..25]
    print lista
    print (soma lista)