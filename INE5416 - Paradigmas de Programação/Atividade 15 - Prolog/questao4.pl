triangulo(X,Y,Z) :-
    X < Y + Z,
    Y < X + Z,
    Z < X + Y.