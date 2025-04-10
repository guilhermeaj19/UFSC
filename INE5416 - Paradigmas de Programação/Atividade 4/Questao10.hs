
maior :: Float -> Float -> Float -> Float
maior a b c | a > b && a > c = a
            | b > c = b
            | otherwise = c

main :: IO ()
main = do
    aStr <- getLine
    let a = (read aStr :: Float)
    bStr <- getLine
    let b = (read bStr :: Float)
    cStr <- getLine
    let c = (read cStr :: Float)
    print(maior a b c)