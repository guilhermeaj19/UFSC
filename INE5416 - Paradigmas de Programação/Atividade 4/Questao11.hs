
maximoDivisor :: Int -> Int -> Int
maximoDivisor x 0 = x
maximoDivisor 0 y = y
maximoDivisor x y =
    if x > y then
        maximoDivisor (x `mod` y) y
    else
        maximoDivisor x (y `mod` x)

main = do
    yStr <- getLine
    let y = (read yStr :: Int)
    xStr <- getLine
    let x = (read xStr :: Int)
    print(maximoDivisor x y)
