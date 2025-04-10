module Ponto (Ponto(Ponto2D), distancia, colineares, formaTriangulo) where

data Ponto = Ponto2D (Float, Float)


distancia :: Ponto -> Ponto -> Float
distancia (Ponto2D (x1,y1)) (Ponto2D (x2,y2)) = sqrt((x2-x1)**2 + (y2-y1)**2)

colineares :: Ponto -> Ponto -> Ponto -> Bool
colineares (Ponto2D (x1,y1)) (Ponto2D (x2,y2)) (Ponto2D (x3,y3)) = (x1*y1 + y1*x3 + x2*y3) - (y2*x3 + x1*y3 + y1*x2) == 0

formaTriangulo :: Ponto -> Ponto -> Ponto -> Bool
formaTriangulo (Ponto2D p1) (Ponto2D p2) (Ponto2D p3) | distancia p1 p2 > (distancia p1 p3 + distancia p2 p3) = True
                                                      | distancia p1 p3 > (distancia p1 p2 + distancia p2 p3) = True
                                                      | distancia p2 p3 > (distancia p1 p2 + distancia p1 p3) = True
                                                      | otherwise = False