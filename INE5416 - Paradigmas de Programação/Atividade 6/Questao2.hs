
type Raio = Float
type Altura = Float
type Largura = Float
type Base = Float
data Forma = Circulo Raio | Retangulo Altura Largura | Triangulo Base Altura

area :: Forma -> Float
area (Circulo raio) = pi * raio * raio
area (Retangulo altura largura) = altura * largura
area (Triangulo base altura) = (base * altura)/2

minhaForma :: Forma
minhaForma = Retangulo 4 6

main = do 
    print (area (Circulo 4))
    print (area (Retangulo 10 5))
    print (area (Triangulo 10 4))
    print (area minhaForma)
