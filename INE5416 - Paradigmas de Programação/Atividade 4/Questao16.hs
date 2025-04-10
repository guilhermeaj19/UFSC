

esDivisivel :: Int -> Int -> Bool
esDivisivel x y | x `mod` y == 0 = True
                | otherwise = False

main = do
    xStr <- getLine
    let x = (read xStr :: Int)
    yStr <- getLine
    let y = (read yStr :: Int)
    print(esDivisivel x y)