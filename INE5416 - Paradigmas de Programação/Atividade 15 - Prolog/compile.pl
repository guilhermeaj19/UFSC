% Este é um comentário
% O predicado main/0 é o ponto de entrada do nosso programa
main :-
    % Carrega o arquivo load.pl
    [load],
    % Compila o código em um arquivo executável
    qsave_program('myapp.exe', [goal=iniciar]).
