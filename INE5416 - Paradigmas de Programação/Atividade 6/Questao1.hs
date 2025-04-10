
type Name = String
type Class = String
type ThreeNotes = (Float, Float, Float)
type Aluno = (Name, Class, ThreeNotes)

aluno :: Int -> Aluno
aluno 1 = ("Carlos", "Quimica", (10,8,9))
aluno 2 = ("Deborah", "Matematica", (5,8,6))
aluno 3 = ("Robertinho do Grau", "Fisica", (2,3,5))
aluno 4 = ("Donald da Mobilete", "Diplomacia", (4,8,1))

getTotalAlunos :: Int
getTotalAlunos = 4

getNome :: Aluno -> Name
getNome (nome, _, _) = nome

getNotes :: Aluno -> ThreeNotes
getNotes (_, _, notas) = notas

getSomaDasNotas :: ThreeNotes -> Float
getSomaDasNotas (n1, n2, n3) = n1 + n2 + n3

getMedia :: Int -> Float
getMedia index = getSomaDasNotas (getNotes (aluno index))/3

getMediaTurma :: Int -> Float
getMediaTurma index | index <= getTotalAlunos = getMedia index/fromIntegral getTotalAlunos + getMediaTurma (index + 1)
                    | otherwise = 0

mediaTurma :: Float
mediaTurma = getMediaTurma 1

main = do
    print (aluno 1)
    print (getNome (aluno 2))
    print (getMedia 1)
    print (getMedia 2)
    print (getMedia 3)
    print (getMedia 4)
    print mediaTurma