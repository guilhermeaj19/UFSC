
areaTriangle :: Float -> Float -> Float
areaTriangle base altura = (base*altura)/2

main :: IO ()
main = do
    alturaStr <- getLine
    baseStr <- getLine
    let altura = (read alturaStr :: Float)
    let base = (read baseStr :: Float)
    print(areaTriangle base altura)
