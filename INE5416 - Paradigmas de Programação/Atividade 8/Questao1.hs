module Questao1 where

import Formas ( Forma(Trapezio), area )

main = do
    print(area (Trapezio 5 2 5))