
%Questao 3
divisivel(N,K) :-
    Z is N mod K,
    Z == 0.

%Questao 4
triangulo(X,Y,Z) :-
    X < Y + Z,
    Y < X + Z,
    Z < X + Y.

%Questao 5
eqSegundoGrau(A,B,C,ValorX) :-
    Delta is B^2 - 4*A*C,
    (ValorX is (-B + sqrt(Delta))/(2*A);
    ValorX is (-B - sqrt(Delta))/(2*A)).

%Questao 6
potencia(X,Y,Resultado) :-
    Resultado is X**Y.

%Questao 7
absoluto(N,X) :-
    (X is N, N >= 0);
    (X is -N, N < 0).

%Questao 8
areaTriangulo(B,A,Area) :-
    Area is B*A/2.

%Questao9
xor(X,Y) :-
    (\+ X, Y);
    (X, \+ Y).

%Questao 10
aprovado(A,B,C) :-
    Media is (A+B+C)/3,
    Media >= 6.

%Questao 11
fib(0, 0) :- !.
fib(1, 1) :- !.
fib(N, K) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, K1),
    fib(N2, K2),
    K is K1 + K2.

%Questao 12
distancia3D(ponto(X1,Y1,Z1), ponto(X2,Y2,Z2), Dist) :-
    Dist is sqrt((X2-X1)**2 + (Y2-Y1)**2 + (Z2-Z1)**2).

%Questao 13
maior(A, B, C, X) :-
    A >= B, A >= C, X = A;
    B >= A, B >= C, X = B;
    C >= A, C >= B, X = C.

%Questao 14
operacao(Op,X,Y,Resultado) :-
    Op == '+', Resultado is X + Y;
    Op == '-', Resultado is X - Y;
    Op == '*', Resultado is X * Y;
    Op == '/', Resultado is X / Y.

%Questao 15
mdc(X, 0, X) :- !.
mdc(X, Y, Resultado) :-
    Z is X mod Y,
    mdc(Y, Z, Resultado).

%Questao 17
mmc(X,Y,Resultado) :-
    mdc(X,Y,MDC), 
    Resultado is (X*Y)/MDC.

%Questao 18
coprimos(X,Y) :-
    mdc(X,Y,MDC),
    MDC == 1.

%Questao 19
totienteEuler(1, [1]) :- !.
totienteEuler(N, Coprimos) :-
    findall(I, (between(1, N, I), coprimos(I, N)), Coprimos).

%Questao 20
primo(2).
primo(N) :- 
    N > 2, 
    \+ ((X), X > 1, X < N, 0 is N mod X).

