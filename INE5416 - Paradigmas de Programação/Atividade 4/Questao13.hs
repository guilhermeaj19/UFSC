
maximoDivisor :: Int -> Int -> Int
maximoDivisor x 0 = x
maximoDivisor 0 y = y
maximoDivisor x y =
    if x > y then
        maximoDivisor (x `mod` y) y
    else
        maximoDivisor x (y `mod` x)

minimoMultiplo :: Int -> Int -> Int
minimoMultiplo x y = (x*y) `div` maximoDivisor x y

main = do
    xStr <- getLine
    let x = (read xStr :: Int)
    yStr <- getLine
    let y = (read yStr :: Int)
    print(minimoMultiplo x y)