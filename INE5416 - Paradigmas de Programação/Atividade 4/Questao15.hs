
maximoDivisor :: Int -> Int -> Int
maximoDivisor x 0 = x
maximoDivisor 0 y = y
maximoDivisor x y =
    if x > y then
        maximoDivisor (x `mod` y) y
    else
        maximoDivisor x (y `mod` x)

esCoprimos :: Int -> Int -> Bool
esCoprimos x y | maximoDivisor x y == 1 = True
               | otherwise = False

numCoprimos :: Int -> Int -> Int
numCoprimos n r | r >= 1 && esCoprimos n r = 1 + numCoprimos n (r-1)
                | r >= 1 = numCoprimos n (r-1)
                | otherwise = 0 

totienteEuler :: Int -> Int
totienteEuler n = numCoprimos n (n-1)

main :: IO ()
main = do
    nStr <- getLine
    let n = (read nStr :: Int)
    print(totienteEuler n)
