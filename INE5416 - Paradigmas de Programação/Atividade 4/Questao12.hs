
maximoDivisor :: Int -> Int -> Int -> Int
maximoDivisor x 0 0 = x
maximoDivisor 0 y 0 = y
maximoDivisor 0 0 z = z
maximoDivisor x y z | x > y && y > z = maximoDivisor (x `mod` z) (y `mod` z)   z
                    | z > y = maximoDivisor          (x `mod` y)  y           (z `mod` y)
                    | otherwise = maximoDivisor       x          (y `mod` x)  (z `mod` x)
main :: IO ()
main = do
    xStr <- getLine
    let x = (read xStr :: Int)
    yStr <- getLine
    let y = (read yStr :: Int)
    zStr <- getLine
    let z = (read zStr :: Int)
    print(maximoDivisor x y z)