
xor :: Bool -> Bool -> Bool
xor xBool yBool = (not xBool && yBool) || (xBool && not yBool)


main = do
    xStr <- getLine
    yStr <- getLine
    let xBool = (read xStr :: Bool)
    let yBool = (read yStr :: Bool)
    print(xor xBool yBool)