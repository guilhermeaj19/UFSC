menor :: [Int] -> Int
menor [] = 0
menor (a:b) | null b = a
            | a < head b = menor (a : tail b)
            | otherwise = menor b

main :: IO ()
main = do
    let lista = [123,52,6,192,1239012,53]
    print lista
    print (menor lista)