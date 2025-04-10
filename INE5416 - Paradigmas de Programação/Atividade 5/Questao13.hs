apagarEnquanto :: (t -> Bool) -> [t] -> [t]
apagarEnquanto _ [] = []
apagarEnquanto function (a:b) | function a = apagarEnquanto function b
                              | otherwise = a:b

main :: IO ()
main = do
    let lista1 = [-123,52,6,-192,1239012,53]
    let lista2 = [5, 5, -1, 5,-5, 4, 2, 3]
    print lista1
    print (apagarEnquanto odd lista1 )
    print lista2
    print (apagarEnquanto odd lista2 )