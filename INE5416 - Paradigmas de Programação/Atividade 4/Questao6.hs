
condExist :: Int -> Int -> Int -> Bool
condExist x y z = (x < y + z) && (y < x + z) && (z < x + y)

main = do
    xStr <- getLine
    let x = (read xStr :: Int)
    yStr <- getLine
    let y = (read yStr :: Int)
    zStr <- getLine
    let z = (read zStr :: Int)
    print(condExist x y z)