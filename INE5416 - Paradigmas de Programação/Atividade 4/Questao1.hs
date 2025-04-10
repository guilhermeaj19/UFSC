
funcao :: Float -> Float -> Float
funcao x y =
    x**y

main :: IO ()
main = do
    xStr <- getLine
    yStr <- getLine
    let x = (read xStr :: Float)
    let y = (read yStr :: Float)
    print(funcao x y)