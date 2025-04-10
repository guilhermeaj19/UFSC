menor :: [Int] -> Int
menor [] = 0
menor (a:b) | null b = a
            | a < head b = menor (a : tail b)
            | otherwise = menor b

maior :: [Int] -> Int
maior [] = 0
maior (a:b) | null b = a
            | a > head b = maior (a : tail b)
            | otherwise = maior b

diferencaMaiorMenor :: [Int] -> Int
diferencaMaiorMenor lista = maior lista - menor lista

main :: IO ()
main = do
    let lista = [123,52,6,192,1239012,53]
    print lista
    print (diferencaMaiorMenor lista)