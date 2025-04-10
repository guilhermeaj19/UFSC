
absValue :: Float -> Float
absValue x | x < 0 = (-1)*x
                | otherwise = x

main :: IO ()
main = do
    xStr <- getLine
    let x = (read xStr :: Float)
    print(absValue x)
                