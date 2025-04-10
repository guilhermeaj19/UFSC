:- use_module(library(clpfd)).
:- consult('readfile.pl'). % Código separado utilizado para ler o arquivo com os comparadores

init_board([[0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0]]).

% Imprime o sudoku na tela
print_sudoku([]).
print_sudoku([Head|Tail]) :- print(Head), nl, print_sudoku(Tail).

% Verifica se Num já está na lista
is_elem([], _) :- false, !.
is_elem([Num|_], Num) :- !.
is_elem([_|List], Num) :- is_elem(List, Num).

% Retorna uma lista com os valores da coluna referente
get_col(J, [Row], [X]) :- nth0(J, Row, X), !.
get_col(J, [Row|Board], [X|Rest]) :- nth0(J, Row, X), get_col(J, Board, Rest).

% Retorna uma lista com os valores do quadrado referente
get_square(Board, Row, Col, Square) :-
    StartRow is (Row // 3) * 3, EndRow is StartRow + 2,
    StartCol is (Col // 3) * 3, EndCol is StartCol + 2,
    findall(Num, (between(StartRow, EndRow, R), nth0(R, Board, SubRow),
                  between(StartCol, EndCol, C), nth0(C, SubRow, Num)), Square).

% Compara se A op B, sendo op = > ou <
comparing(1, '>', _) :- false, !. % 1 > Any é sempre falso
comparing(9, '<', _) :- false, !. % 9 < Any é sempre falso
comparing(_, '<', 1) :- false, !.
comparing(_, '>', 9) :- false, !.
comparing(0, _, _) :- !. % 0 é valor para posição vazia, então sempre verdade
comparing(_, _, 0) :- !.
comparing(A, '>', B) :- A > B, !. % Comparações em si
comparing(A, '<', B) :- A < B, !.

% Retorna o valor da célula da posição (I, J) do Board
get_cell(Matrix, I, J, Cell) :-
    nth0(I, Matrix, Row),
    nth0(J, Row, Cell).

% Avalia se o palpite é valido em relação aos comparadores
check_comps(Board, I, J, Num, CompH, CompV) :-
    ModI is I mod 3, % Linha relativa ao quadrado
    ModJ is J mod 3, % Coluna relativa ao quadrado

    % Comparadores em relação à linha (em cima e/ou em baixo)
    ((ModI =:= 0 -> Iplus is I + 1,
                    get_cell(CompV, I, J, CompV_Down),
                    get_cell(Board, Iplus, J, CellDown),
                    comparing(Num, CompV_Down, CellDown), !
     );
     (ModI =:= 1 -> Iplus is I + 1,
                    Iminus is I - 1,
                    get_cell(CompV, I, J, CompV_Down),
                    get_cell(CompV, Iminus, J, CompV_Up),
                    get_cell(Board, Iplus, J, CellDown),
                    get_cell(Board, Iminus, J, CellUp),
                    comparing(Num, CompV_Down, CellDown),
                    comparing(CellUp, CompV_Up, Num), !
     );
     (ModI =:= 2 -> Iminus is I - 1,
                    get_cell(CompV, Iminus, J, CompV_Up),
                    get_cell(Board, Iminus, J, CellUp),
                    comparing(CellUp, CompV_Up, Num), !
     )
    
    % Comparadores em relação à coluna (à esquerda e/ou direita)
    ),
    ((ModJ =:= 0 -> Jplus is J + 1,
                    get_cell(CompH, I, J, CompH_Right),
                    get_cell(Board, I, Jplus, CellRight),
                    comparing(Num, CompH_Right, CellRight), !
     );
     (ModJ =:= 1 -> Jplus is J + 1,
                    Jminus is J - 1,
                    get_cell(CompH, I, J, CompH_Right),
                    get_cell(CompH, I, Jminus, CompH_Left),
                    get_cell(Board, I, Jplus, CellRight),
                    get_cell(Board, I, Jminus, CellLeft),
                    comparing(Num, CompH_Right, CellRight),
                    comparing(CellLeft, CompH_Left, Num), !
     );
     (ModJ =:= 2 -> Jminus is J - 1,
                    get_cell(CompH, I, Jminus, CompH_Left),
                    get_cell(Board, I, Jminus, CellLeft),
                    comparing(CellLeft, CompH_Left, Num), !
     )
    ).

% Avalia se o palpite é válido
is_valid(Board, I, J, Num, CompH, CompV) :- nth0(I, Board, Row),
                                            (
                                            (is_elem(Row, Num), !, false); % Palpite já está na linha?
                                            (get_square(Board, I, J, Square), is_elem(Square, Num), !, false); % Palpite já está no quadrado?
                                            (get_col(J, Board, Col), is_elem(Col, Num), !, false); % Palpite já está na coluna?
                                            (check_comps(Board, I, J, Num, CompH, CompV), !) % O palpite é válido pros comparadores adjacentes à posição?
                                            ).

% Se chegar no fim do Board, printa a solução
solve_sudoku(Board, 9, _, _, _) :- print_sudoku(Board), !.

% Chegou no fim de uma linha, vai para a próxima
solve_sudoku(Board, Row, 9, CompH, CompV) :-
    NewRow is Row + 1,
    solve_sudoku(Board, NewRow, 0, CompH, CompV).

% Se a posição atual já está preenchida, vai para a próxima posição
solve_sudoku(Board, Row, Col, CompH, CompV) :-
    nth0(Row, Board, R), nth0(Col, R, Num), Num \= 0,
    NewCol is Col + 1,
    solve_sudoku(Board, Row, NewCol, CompH, CompV).

solve_sudoku(Board, Row, Col, CompH, CompV) :-
    % Se a posição atual está vazia, busca um palpite válido
    nth0(Row, Board, R), nth0(Col, R, Num), Num = 0,
    between(1, 9, Guess),
    is_valid(Board, Row, Col, Guess, CompH, CompV),

    % Substitua o 0 pelo palpite válido
    replace_in_row(R, Col, Guess, NewR), replace_in_row(Board, Row, NewR, NewBoard),
    
    % Vai para próxima posição
    NewCol is Col + 1,
    solve_sudoku(NewBoard, Row, NewCol, CompH, CompV).

% Substitui o elemento em uma determinada posição na lista
replace_in_row([_|T], 0, X, [X|T]).
replace_in_row([H|T], Col, X, [H|RT]) :-
    Col > 0,
    NewCol is Col - 1,
    replace_in_row(T, NewCol, X, RT).

% Recebe um nome de arquivo que contem os comparadores, separa-os em 
% horizontais e verticais e inicia a busca pela solução
solve(Filename) :-
    (init_board(Board),
    read_file(Filename, Lines),
    slice(Lines, 0, 9, CompH),
    slice(Lines, 10, 9, CompV),
    solve_sudoku(Board, 0, 0, CompH, CompV), !); 
    write('Solucao nao encontrada'), false, !.

