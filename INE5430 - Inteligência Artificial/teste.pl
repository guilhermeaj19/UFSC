% Base de conhecimentos: vinhos e suas características
vinho(bordeaux_blanc, branco, seco, leve, media, nao_frutado).
vinho(sauvignon_blanc, branco, seco, leve, alta, nao_frutado).
vinho(riesling, branco, demi_seco, leve, baixa, frutado).
vinho(rose_de_provence, rose, demi_seco, leve, baixa, frutado).
vinho(pinot_noir, tinto, seco, encorpado, media, nao_frutado).
vinho(merlot, tinto, seco, medio_encorpado, media, nao_frutado).
vinho(cabernet_sauvignon, tinto, seco, encorpado, alta, nao_frutado).

% Regra para encontrar vinhos com certas características
recomendar_vinho(Cor, Tipo, Corpo, Vinho) :-
    vinho(Vinho, Cor, Tipo, Corpo, _, _).
