:- use_module(library(clpfd)).
:- consult('readfile.pl'). 

sudoku(Rows, CompH, CompV) :-
    length(Rows, 9), maplist(same_length(Rows), Rows),
    append(Rows, Vs), Vs ins 1..9,
    valid(Rows, CompH, CompV),
    maplist(label, Rows).

valid(Rows, CompH, CompV) :-
    forall((between(0, 8, I), between(0, 8, J)), check_comps(Rows, I, J, CompH, CompV)),
    maplist(all_distinct, Rows),
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),
    Rows = [A,B,C,D,E,F,G,H,I],
    blocks(A, B, C), blocks(D, E, F), blocks(G, H, I).

comparing(A, _, B) :- ((var(A); var(B)) -> true, !).
comparing(A, '>', B) :- (nonvar(A), nonvar(B) -> A > B, !).
comparing(A, '<', B) :- (nonvar(A), nonvar(B) -> A < B, !).

% Retorna o valor da célula da posição (I, J) do Board
get_cell(Matrix, I, J, Cell) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Cell).


% Avalia se o palpite é valido em relação aos comparadores
check_comps(Board, I, J, CompH, CompV) :-
    ModI is I mod 3, % Linha relativa ao quadrado
    ModJ is J mod 3, % Coluna relativa ao quadrado
    get_cell(Board, I, J, CurrentCell),
    % Comparadores em relação à linha (em cima e/ou em baixo)
    ((ModI =:= 0 -> Iplus is I + 1,
                    get_cell(CompV, I, J, CompV_Down),
                    get_cell(Board, Iplus, J, CellDown),
                    comparing(CurrentCell, CompV_Down, CellDown), !
     );
     (ModI =:= 1 -> Iplus is I + 1,
                    Iminus is I - 1,
                    get_cell(CompV, I, J, CompV_Down),
                    get_cell(CompV, Iminus, J, CompV_Up),
                    get_cell(Board, Iplus, J, CellDown),
                    get_cell(Board, Iminus, J, CellUp),
                    comparing(CurrentCell, CompV_Down, CellDown),
                    comparing(CellUp, CompV_Up, CurrentCell), !
     );
     (ModI =:= 2 -> Iminus is I - 1,
                    get_cell(CompV, Iminus, J, CompV_Up),
                    get_cell(Board, Iminus, J, CellUp),
                    comparing(CellUp, CompV_Up, CurrentCell), !
     )
    
    % Comparadores em relação à coluna (à esquerda e/ou direita)
    ),
    ((ModJ =:= 0 -> Jplus is J + 1,
                    get_cell(CompH, I, J, CompH_Right),
                    get_cell(Board, I, Jplus, CellRight),
                    comparing(CurrentCell, CompH_Right, CellRight), !
     );
     (ModJ =:= 1 -> Jplus is J + 1,
                    Jminus is J - 1,
                    get_cell(CompH, I, J, CompH_Right),
                    get_cell(CompH, I, Jminus, CompH_Left),
                    get_cell(Board, I, Jplus, CellRight),
                    get_cell(Board, I, Jminus, CellLeft),
                    comparing(CurrentCell, CompH_Right, CellRight),
                    comparing(CellLeft, CompH_Left, CurrentCell), !
     );
     (ModJ =:= 2 -> Jminus is J - 1,
                    get_cell(CompH, I, Jminus, CompH_Left),
                    get_cell(Board, I, Jminus, CellLeft),
                    comparing(CellLeft, CompH_Left, CurrentCell), !
     )
    ).

blocks([], [], []).
blocks([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :-
    all_distinct([A,B,C,D,E,F,G,H,I]),
    blocks(Bs1, Bs2, Bs3).

problem(1, [[_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_]]).
print_sudoku([]).
print_sudoku([Head|Tail]) :- print(Head), nl, print_sudoku(Tail).
solve(Filename) :-
    (problem(1,Board),
    read_file(Filename, Lines),
    slice(Lines, 0, 9, CompH),
    slice(Lines, 10, 9, CompV),
    sudoku(Board, CompH, CompV), print_sudoku(Board), !); 
    write('Solucao nao encontrada'), false, !.