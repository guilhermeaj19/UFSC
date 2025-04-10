


esDivisivel :: Int -> Int -> Bool
esDivisivel x y | x `mod` y == 0 = True
                | otherwise = False

numDivisiveis :: Int -> Int -> Int
numDivisiveis n m | m >= 1 && esDivisivel n m = 1 + numDivisiveis n (m-1)
                  | m >= 1 = numDivisiveis n (m-1)
                  | otherwise = 0 
 
esPrimo :: Int -> Bool
esPrimo n | numDivisiveis n n == 2 = True
          | otherwise = False

main = do
    nStr <- getLine
    let n = (read nStr :: Int)
    print(esPrimo n)