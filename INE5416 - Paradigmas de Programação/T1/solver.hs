import qualified Data.Vector as V
import qualified Data.Text    as Text
import qualified Data.Text.IO as Text
import System.Environment (getArgs) --Para ler os argumentos do terminal

newtype Board = Board (V.Vector (V.Vector Integer)) --Armazena os valores
newtype Comparadores = Comparadores (V.Vector (V.Vector String)) --Armazena os comparadores (horizontais ou verticais)
type Row = Int --linha
type Column = Int --coluna
type Position = (Row, Column) --posição

--Impressão do Board de forma linha a linha
instance Show Board where
 show (Board b)= unlines . V.toList $ V.map show b

--Conversão para o tipo Board
fromList :: [[Integer]] -> Board
fromList l = Board $ V.fromList $ V.fromList <$> l

--Conversão para o tipo Comparadores
fromListString :: [[String]] -> Comparadores
fromListString l = Comparadores $ V.fromList $ V.fromList <$> l

-- Devolve o valor na posição escolhida no Board
(!):: Board -> Position -> Integer
(Board b) ! (i,j) = (b  V.! i)V.! j

-- Devolve o comparador referente à posição na matriz
getComp:: Comparadores -> Position -> String
getComp (Comparadores c) (i,j) = (c  V.! i)V.! j

-- Devolve linha referente
getRow :: Board -> Position -> [Integer]
getRow b (i, _) = [b ! (i, j) | j<-[0..8]]

--Devolve coluna referente
getColumn :: Board -> Position -> [Integer]
getColumn b (_, j) = [b ! (i, j) | i<-[0..8]]

--Devolve quadrado referente, baseando na posição i e j recebida
getSquare :: Board -> Position -> [Integer]
getSquare b (i,j) = [b ! ((i-i `mod ` 3)+u,(j-j `mod ` 3)+v) | u<-[0..2],v<-[0..2]] --i - i mod 3: primeira linha do quadrado
                                                                                    --j - j mod 3: primeira coluna do quadrado
-- Insere o valor na posição escolhida
insert :: Board -> Position -> Integer -> Board
insert (Board b) (i, j) k = Board b'
 where v = b V.! i
       v' = v V.// [(j, k)] --insere na posição j o valor k
       b' = b V.// [(i, v')] --insere na linha i o vetor v' criado

--Checa se a comparação é verdadeira
comparing :: Integer -> String -> Integer -> Bool
comparing 1 ">" _ = False --1 nunca será maior que qualquer outro número de 1 a 9
comparing _ "<" 1 = False
comparing 9 "<" _ = False --9 nunca será menor que qualquer outro número de 1 a 9
comparing _ ">" 9 = False
comparing 0 _ 0 = True --0 é um valor sem importância nesse contexto, então qualquer opção de 1 a 9 seria verdade
comparing 0 _ _ = True
comparing _ _ 0 = True
comparing a comparador b | comparador == "<" = a < b
                         | comparador == ">" = a > b
                         | otherwise = True

-- Checa se é possível esse número na posicão referente
possible :: Board -> Comparadores -> Comparadores -> Position -> Integer -> Bool
possible b compH compV coords@(i, j) k
                            |i < 0 || i >= 9 || j < 0 || j >= 9 || k < 0 || k > 9 = undefined
                            |b ! coords > 0 = False --posição já tem um valor
                            |k `elem` getRow b coords = False --o número já está presente na linha
                            |k `elem` getColumn b coords = False --o número já está presente na coluna
                            |k `elem` getSquare b coords = False --o número já está presente no quadrado

                            --As demais verificações são feitas para analisar cada uma das posições de um quadrado, visto
                            --que cada posição tem uma quantidade diferente de comparações referentes a ela
                            |i `mod` 3 == 0 && j `mod` 3 == 0 = comparing   k            (getComp compH (i  , j  ))   (b!(i,j+1)) && 
                                                                comparing   k            (getComp compV (i  , j  ))   (b!(i+1,j))

                            |i `mod` 3 == 0 && j `mod` 3 == 1 = comparing  (b!(i,j-1))   (getComp compH (i  , j-1))    k          &&
                                                                comparing   k            (getComp compH (i  , j  ))   (b!(i,j+1)) &&
                                                                comparing   k            (getComp compV (i  , j  ))   (b!(i+1,j))

                            |i `mod` 3 == 0 && j `mod` 3 == 2 = comparing  (b!(i,j-1))   (getComp compH (i  , j-1))    k          &&
                                                                comparing   k            (getComp compV (i  , j  ))   (b!(i+1,j))

                            |i `mod` 3 == 1 && j `mod` 3 == 0 = comparing   k            (getComp compH (i  , j  ))   (b!(i,j+1)) &&
                                                                comparing   k            (getComp compV (i  , j  ))   (b!(i+1,j)) &&
                                                                comparing  (b!(i-1,j))   (getComp compV (i-1, j  ))    k         

                            |i `mod` 3 == 1 && j `mod` 3 == 1 = comparing   k            (getComp compH (i  , j  ))   (b!(i,j+1)) &&
                                                                comparing   k            (getComp compV (i  , j  ))   (b!(i+1,j)) &&
                                                                comparing  (b!(i-1,j))   (getComp compV (i-1, j  ))    k          &&
                                                                comparing  (b!(i,j-1))   (getComp compH (i  , j-1))    k         

                            |i `mod` 3 == 1 && j `mod` 3 == 2 = comparing   k            (getComp compV (i  , j  ))   (b!(i+1,j)) &&
                                                                comparing  (b!(i-1,j))   (getComp compV (i-1, j  ))    k          &&
                                                                comparing  (b!(i,j-1))   (getComp compH (i  , j-1))    k         

                            |i `mod` 3 == 2 && j `mod` 3 == 0 = comparing   k            (getComp compH (i  , j  ))   (b!(i,j+1)) &&
                                                                comparing  (b!(i-1,j))   (getComp compV (i-1, j  ))    k         

                            |i `mod` 3 == 2 && j `mod` 3 == 1 = comparing   k            (getComp compH (i  , j  ))   (b!(i,j+1)) &&
                                                                comparing  (b!(i-1,j))   (getComp compV (i-1, j  ))    k          &&
                                                                comparing  (b!(i,j-1))   (getComp compH (i  , j-1))    k        
 
                            | otherwise =                       comparing  (b!(i-1,j))   (getComp compV (i-1, j  ))    k          &&
                                                                comparing  (b!(i,j-1))   (getComp compH (i  , j-1))    k         

-- Checando se a posição está vazia (0)
isEmpty :: Board -> Position -> Bool
isEmpty b coords = b ! coords == 0

-- Checando se o tabuleiro tá completo
full :: Board -> Bool
full b = 0 `notElem` [b ! (i,j) | i<-[0..8], j<-[0..8]]

-- Vai buscar a primeira solução possível
solve :: Board -> Comparadores -> Comparadores -> Maybe Board
solve b compH compV
 | full b = Just b
 | otherwise =  findSolution $ [ solve (insert b (x, y) n) compH compV |
                                (x,y) <- take 1 empty,
                                n <- [1..9],
                                possible b compH compV (x,y) n]
        where   empty = [(x,y) | x<-[0..8],y<-[0..8], isEmpty b (x, y)]
                findSolution [] = Nothing --Não há solução possível
                findSolution (Nothing:xs) = findSolution xs --Executa a próxima opção
                findSolution ((Just b):_) = Just b --Encontrou a solução, acabou a busca

--Cria um vetor com os caracteres de uma string (exceto ' ')
createLine :: String -> [String]
createLine [' '] = []
createLine [] = []
createLine (' ':b) = createLine b
createLine (a:b) = [a] : createLine b

--Cria a matriz de comparadores a partir de um vetor de strings
split :: [String] -> [[String]]
split [] = []
split ("":b) = split b --Ajuste devido à forma que o Text.Split (no main) funciona
split (a:b)= createLine a : split b

--Imprime o resultado, mas sem o Just
printar :: Maybe Board -> IO ()
printar (Just b) = print b
printar b = print b

main = do
    args <- getArgs --Coleta os argumentos do terminal

    --Se não receber um arquivo pelo terminal, utiliza o arquivo padrão
    let textPath = if length args /= 1 then "defaultPuzzle.txt"  else head args

    --Coleta o conteúdo do arquivo
    contentsText <- Text.readFile textPath

    --Conversão do arquivo lido para os comparadores horizontais e verticais
    let comps =   map
                 (map Text.unpack . Text.split (== '\n'))
                 (Text.split (== '.') contentsText)

    let compH = fromListString (split (comps!!0)) --Comparadores horizontais
    let compV = fromListString (split (comps!!1)) --Comparadores verticais

    --Por padrão, o quebra-cabeça sempre começa sem nenhuma posição resolvida
    let b = fromList [[0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0]]

    printar (solve b compH compV)
