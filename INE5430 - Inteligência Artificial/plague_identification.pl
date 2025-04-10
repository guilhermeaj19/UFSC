% Definição das pragas e os sintomas causados a planta
praga(pulgao, [folhas_amarelas, folhas_enfraquecidas, folhas_deformadas, manchas_pegajosas, presenca_insetos]).
praga(acaro, [folhas_amarelas, folhas_murchas, presenca_teias, presenca_crostas, crescimento_afetado]).
praga(mosca_branca, [folhas_amarelas, folhas_murchas, manchas_negras, presenca_insetos]).
praga(broca, [folhas_amarelas, folhas_enfraquecidas, folhas_murchas, folhas_buracos, crescimento_afetado]).
praga(lesma_caracol, [folhas_enfraquecidas, folhas_murchas, folhas_buracos, presenca_moluscos]).
praga(lagarta, [folhas_roidas, presenca_lagartas, presenca_fezes, frutos_danificados]).
praga(fungos, [folhas_deformadas, folhas_secas, manchas_varias_cores, presenca_mofo, crescimento_afetado, frutos_danificados, cheiro_desgradavel]).
praga(nematoides, [raizes_deformadas]).

% Verifica quais pragas correspondem aos sintomas fornecidos
diagnostico(Praga, Sintomas) :-
    praga(Praga, SintomasPraga),
    subset(Sintomas, SintomasPraga).

%Exemplo uma praga:
% ?- diagnostico(X, [folhas_amarelas, folhas_enfraquecidas, presenca_insetos]).
% X = pulgao;
% false.

%Exemplo múltiplas alternativas de praga:
% ?- diagnostico(X, [folhas_amarelas]).                                       
% X = pulgao ;
% X = acaro ;
% X = mosca_branca ;
% X = broca ;
% false.
