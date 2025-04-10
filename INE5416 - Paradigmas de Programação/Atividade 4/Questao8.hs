bhaskara :: Float -> Float -> Float -> [Float]
bhaskara a b c = 
    result where
        delta = sqrt(b**2 - 4*a*c)
        result = [(-b + delta)/(2*a), (-b - delta)/(2*a)]

main = do
    aStr <- getLine
    let a = (read aStr :: Float)
    bStr <- getLine
    let b = (read bStr :: Float)
    cStr <- getLine
    let c = (read cStr :: Float)

    print(bhaskara a b c)