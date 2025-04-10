apagar :: Int -> [t] -> [t]
apagar 0 lista = lista
apagar _ [] = []
apagar nElementos (a:b) = apagar (nElementos-1) b

main :: IO ()
main = do
    let lista1 = [-123,52,6,-192,1239012,53]
    let lista2 = [5, 5, -1, 5,-5, 4, 2, 3]
    print lista1
    print (apagar 3 lista1 )
    print lista2
    print (apagar 4 lista2 )