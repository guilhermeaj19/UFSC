

estuda(gui, ine5416). 
estuda(caio, ine5416). 
estuda(deborah, ine5412). 
estuda(anaAmorDaMinhaVida, ine5413). 
estuda(gui, ine5413). 

leciona(marcos, ine5416).
leciona(rafael, ine5413).
leciona(marcio, ine5412).

ensina(Prof, Aluno) :- leciona(Prof, Turma), estuda(Aluno, Turma).

colegas(A1, A2) :- estuda(A1,Turma), estuda(A2,Turma), A1 \== A2.