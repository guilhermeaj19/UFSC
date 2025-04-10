%Questao 1
posicao(X, [X|_], 0) :- !.
posicao(X, [_|Cauda], P) :-
    posicao(X, Cauda, P1),
    P is P1 + 1.

%Questao 2
inserirElementoPosicao(X, 0, L1, [X|L1]).
inserirElementoPosicao(X, P, [Cabeca|Cauda1], [Cabeca|Cauda2]) :-
    P > 0,
    NovoP is P - 1,
    inserirElementoPosicao(X, NovoP, Cauda1, Cauda2).

%Questao 3
numeroParaPalavra(0, 'zero').
numeroParaPalavra(1, 'um').
numeroParaPalavra(2, 'dois').
numeroParaPalavra(3, 'tres').
numeroParaPalavra(4, 'quatro').
numeroParaPalavra(5, 'cinco').
numeroParaPalavra(6, 'seis').
numeroParaPalavra(7, 'sete').
numeroParaPalavra(8, 'oito').
numeroParaPalavra(9, 'nove').

numerosParaPalavras([], []).
numerosParaPalavras([Cabeca1|Cauda1], [Cabeca2|Cauda2]) :-
    numeroParaPalavra(Cabeca1, Cabeca2),
    numerosParaPalavras(Cauda1, Cauda2).

%Questao 4
soma([],0) :- !.
soma([H|C],X) :-
    soma(C,X1),
    X is X1 + H.

%Questao 5
media([], 0).
media(L, X) :-
    soma(L, Soma),
    length(L, Size),
    X is Soma/Size.

%Questao 6
menor([],'Lista Vazia').
menor([A],A).
menor([A|[B|C]],X) :-
    (A<B, menor([A|C],X));
    menor([B|C],X).

maior([],'Lista Vazia').
maior([A],A).
maior([A|[B|C]],X) :-
    (A>B, maior([A|C],X));
    maior([B|C],X).

%Questao 7
palindrome([]).
palindrome([_]).
palindrome([H|T]) :- append(Middle, [H], T), palindrome(Middle).

%Questao 8
difMaxMin([],'Lista Vazia').
difMaxMin(L,X) :-
    maior(L,Maior),
    menor(L,Menor),
    X is Maior - Menor.

%Questao9
ocorrencias([],_,0).
ocorrencias([A|B],X,N) :-
    ocorrencias(B,X,N1),
    ((A == X, N is 1 + N1);
     (A \== X, N is N1)).

%Questao10
ultimo([],'Lista Vazia').
ultimo([A],A).
ultimo([_|B],X) :-
    ultimo(B,X).

inverte([A],[A]).
inverte(L1, [H|C]) :-
    ultimo(L1, Last),
    append(MinusLast, [Last], L1),
    H is Last,
    inverte(MinusLast,C).

%Questao11
primeiros(0,_,[]) :- !.
primeiros(N,[H1|C1],[H1|C2]) :-
    NewN is N-1,
    primeiros(NewN, C1, C2).

%Questao12
apagar(0,L1,L1) :- !.
apagar(N,[_|C1],L2) :-
    NewN is N-1,
    apagar(NewN, C1, L2).

%Questao13
dividir([], [], []).
dividir([A], [A], []).
dividir([A, B|C], [A|D], [B|E]) :-
    dividir(C, D, E).

%Questao14
uniao([], S2, S2) :- !.
uniao([H|T], S2, [H|S3]) :-
    \+ member(H, S2),
    uniao(T, S2, S3).
uniao([H|T], S2, S3) :-
    member(H, S2),
    uniao(T, S2, S3).

%Questao15
diferenca([], _, []) :- !.
diferenca([H|T], S2, [H|S3]) :-
    \+ member(H, S2),
    diferenca(T, S2, S3).
diferenca([H|T], S2, S3) :-
    member(H, S2),
    diferenca(T, S2, S3).