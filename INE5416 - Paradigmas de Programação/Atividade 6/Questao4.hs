data Arvore = Null | No Int Arvore Arvore

minhaArvore :: Arvore
minhaArvore = No 52 (No 32 (No 12 Null Null) (No 35 Null Null)) (No 56 (No 55 Null Null) (No 56 (No 55 Null Null) (No 64 Null Null)))

somaElementos :: Arvore -> Int
somaElementos Null = 0
somaElementos (No n esq dir) = n + somaElementos esq + somaElementos dir

buscaElemento :: Arvore -> Int -> Bool
buscaElemento Null _ = False
buscaElemento (No n esq dir) x 
    | n == x = True                           
    | otherwise = buscaElemento esq x || buscaElemento dir x

limiteSup :: Int
limiteSup = 1000 --Define um limite superior para o maior número

minimo :: Int -> Int -> Int
minimo x y | x < y = x
           | otherwise = y

minimoElemento :: Arvore -> Int
minimoElemento Null = limiteSup 
minimoElemento (No n esq dir) = 
    minimo n (minimo (minimoElemento esq) (minimoElemento dir))

ocorrenciasElemento :: Arvore -> Int -> Int
ocorrenciasElemento Null _ = 0
ocorrenciasElemento (No valor esq dir) num | num == valor = 1 + ocorrenciasElemento esq num + ocorrenciasElemento dir num
                                           | otherwise = ocorrenciasElemento esq num + ocorrenciasElemento dir num

maioresQueElemento :: Arvore -> Int -> Int
maioresQueElemento Null _ = 0
maioresQueElemento (No valor esq dir) num | valor > num = 1 + maioresQueElemento esq num + maioresQueElemento dir num
                                          | otherwise = maioresQueElemento esq num + maioresQueElemento dir num

quantidade :: Arvore -> Int
quantidade Null = 0
quantidade (No _ esq dir) = 1 + quantidade esq + quantidade dir

mediaElementos :: Arvore -> Float
mediaElementos (No valor esq dir) = fromIntegral (somaElementos (No valor esq dir))/fromIntegral (quantidade (No valor esq dir))

elementos :: Arvore -> [Int]
elementos Null = []
elementos (No valor esq dir) = [valor] ++ elementos esq ++ elementos dir


main = do 
    print(ocorrenciasElemento minhaArvore 52)
    print(maioresQueElemento minhaArvore 52)
    print(mediaElementos minhaArvore)
    print(quantidade minhaArvore)
    print(elementos minhaArvore)
