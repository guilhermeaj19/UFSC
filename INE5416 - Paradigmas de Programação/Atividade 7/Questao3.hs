class (Integral x) => MeuInt x where

    bigger :: x -> x -> x
    bigger a b | a > b = a
               | otherwise = b

    smaller :: x -> x -> x
    smaller a b | a == (bigger a b) = b
                | otherwise = a

    par :: x -> Bool
    par x = even x

    impar :: x -> Bool
    impar x = odd x

    countDivisores :: x -> x -> Int
    countDivisores x 0 = 0
    countDivisores x n | x `mod` n == 0 =  1 + countDivisores x (n-1)
                       | otherwise = countDivisores x (n-1)

    primo :: x -> Bool
    primo x = countDivisores x x == 2

    (===) :: x -> x -> Bool
    (===) x y = abs(x - y) < 1

instance MeuInt Integer
instance MeuInt Int

main = do
    let a = 2::Integer
    let b = 5::Integer
    print (bigger a b)
    print (smaller a b)
    print (primo (5::Integer))
    print (primo (10::Integer))
    print ((10::Integer) === (5::Integer))
