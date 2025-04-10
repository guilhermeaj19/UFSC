primeiros :: Int -> [t] -> [t]
primeiros 0 _ = []
primeiros _ [] = []
primeiros nElementos (a:b) = a : primeiros (nElementos-1) b

main :: IO ()
main = do
    let lista1 = [-123,52,6,-192,1239012,53]
    let lista2 = [5, 5, -1, 5,-5, 4, 2, 3]
    print lista1
    print (primeiros 3 lista1 )
    print lista2
    print (primeiros 4 lista2 )