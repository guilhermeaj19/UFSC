eqSegundoGrau(A,B,C,ValorX) :-
    Delta is B^2 - 4*A*C,
    (ValorX is (-B + sqrt(Delta))/(2*A);
    ValorX is (-B - sqrt(Delta))/(2*A)).
