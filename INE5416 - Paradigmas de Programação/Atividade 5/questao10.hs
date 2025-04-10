filtrar :: (t -> Bool) -> [t] -> [t]
filtrar funcao lista = [b | b <- lista, funcao b]

main :: IO ()
main = do
    let lista1 = [-123,52,6,-192,1239012,53]
    let lista2 = [5, 5, -1, 5,-5, 4, 2, 3]
    print lista1
    print (filtrar (>5) lista1 )
    print lista2
    print (filtrar (>5) lista2 )