mapear :: (t -> y) -> [t] -> [y]
mapear _ [] = []
mapear funcao (a:b) = funcao a : mapear funcao b

main :: IO ()
main = do
    let lista1 = [-123,52,6,-192,1239012,53]
    let lista2 = [5, 5, -1, 5,-5, 4, 2, 3]
    print lista1
    print (mapear abs lista1 )
    print lista2
    print (mapear abs lista2 )