
soma :: [Int] -> Int
soma [] = 0
soma (a:b) = a + soma b

media :: [Int] -> Float
media [] = 0
media lista = fromIntegral (soma lista) / fromIntegral (length lista)

main :: IO ()
main = do
    let lista = [1,52,6,192,1239012,53]
    print lista
    print (media lista)