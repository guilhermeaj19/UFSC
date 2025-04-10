dist2pontos3d :: [Float] -> [Float] -> Float
dist2pontos3d point1 point2 = 
    sqrt((head point1 - head point2)**2 + (point1!!1 - point2!!1)**2 + (point1!!2 - point2!!2)**2)


main :: IO ()
main = do
    x1Str <- getLine
    let x1 = (read x1Str :: Float)
    y1Str <- getLine
    let y1 = (read y1Str :: Float)
    z1Str <- getLine
    let z1 = (read z1Str :: Float)
    x2Str <- getLine
    let x2 = (read x2Str :: Float)
    y2Str <- getLine
    let y2 = (read y2Str :: Float)
    z2Str <- getLine
    let z2 = (read z2Str :: Float)
    let point1 = [x1, y1, z1]
    let point2 = [x2, y2, z2]
    print(dist2pontos3d point1 point2)
