simpleCalculator :: Float -> Float -> String -> Float
simpleCalculator x y op | op == "+" = x + y
                        | op == "-" = x - y
                        | op == "*" = x * y
                        | op == "/" = x / y
                        | otherwise = 1/0

main = do
    xStr <- getLine
    let x = (read xStr :: Float)
    yStr <- getLine
    let y = (read yStr :: Float)
    op <- getLine
    print(simpleCalculator x y op)