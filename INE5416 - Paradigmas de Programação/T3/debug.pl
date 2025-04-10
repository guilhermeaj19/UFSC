%Arquivo extra utilizado para avaliar os tempos de execução para os puzzles testados

media(Lista, Media) :-
    soma(Lista, Soma),
    length(Lista, Length),
    Length > 0,
    Media is Soma / Length.

soma([], 0).
soma([Head|Tail], Total) :-
    soma(Tail, Rest),
    Total is Head + Rest.

imprimir_media(Puzzle, Valor) :-
    format('Media para o Puzzle ~w: ~w ms.~n', [Puzzle, Valor]).

testes :-
    test(3, 'puzzle97.txt', Times97), nl,
    media(Times97, Media97),
    imprimir_media(97, Media97),
    write(Times97), nl,

    test(3, 'puzzle170.txt', Times170), nl,
    imprimir_media(170, Media170),
    media(Times170, Media170),
    write(Times170),

    test(3, 'puzzle117.txt', Times117), nl,

    media(Times117, Media117),
    imprimir_media(117, Media117),
    write(Times117), 
    !.

test(0, _, _) :- !.
test(N, Filename, [Time|Times]) :-
    statistics(walltime, [_ | _]), 
    solve(Filename), 
    statistics(walltime, [_ | [Time]]), 
    N1 is N - 1,
    test(N1, Filename, Times).