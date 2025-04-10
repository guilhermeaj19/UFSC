
type X = Float
type Y = Float
type Z = Float
data Ponto = Ponto2D X Y | Ponto3D X Y Z

distancia :: Ponto -> Ponto -> Float
distancia (Ponto2D x1 y1) (Ponto2D x2 y2) = sqrt((x2 - x1)**2 + (y2 - y1)**2)
distancia (Ponto3D x1 y1 z1) (Ponto3D x2 y2 z2) = sqrt((x2 - x1)**2 + (y2 - y1)**2 + (z2 - z1)**2)

main = do
    print (distancia (Ponto2D 1 2) (Ponto2D 2 6))
    print (distancia (Ponto3D 5 1 3) (Ponto3D 5 6 1))