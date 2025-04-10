genitor(pam, bob).
genitor(tom, bob).
genitor(tom, liz).

genitor(bob, ana).
genitor(bob, pat).

genitor(liz,bill).

genitor(pat, jim).

mulher(pam).
mulher(liz).
mulher(pat).
mulher(ana).
homem(tom).
homem(bob).
homem(jim).
homem(bill).

pai(X,Y) :- genitor(X,Y), homem(X).
mae(X,Y) :- genitor(X,Y), mulher(X).

avo(AvoX, X) :- genitor(GenitorX, X), genitor(AvoX, GenitorX), homem(AvoX).
avoh(AvohX, X) :- genitor(GenitorX, X), genitor(AvohX, GenitorX), mulher(AvohX).
irmao(X,Y) :- genitor(PaiAmbos, X), genitor(PaiAmbos, Y), X \== Y, homem(X).
irma(X,Y) :- genitor(PaiAmbos, X), genitor(PaiAmbos, Y), X \== Y, mulher(X).
irmaos(X,Y) :- (irmao(X,Y); irma(X,Y)), X \== Y.
tio(X,Y) :- genitor(GenitorY, Y), irmao(X, GenitorY).
tia(X,Y) :- genitor(GenitorY, Y), irma(X, GenitorY).
primo(X,Y) :- genitor(GenitorX, X), genitor(GenitorY, Y), (irmao(GenitorX, GenitorY); irma(GenitorX, GenitorY)), homem(X).
prima(X,Y) :- genitor(GenitorX, X), genitor(GenitorY, Y), (irmao(GenitorX, GenitorY); irma(GenitorX, GenitorY)), mulher(X).
primos(X,Y) :- (prima(X,Y); primo(X,Y)).
bisavo(X,Y) :- (avo(AvoY,Y), pai(X, AvoY)) ; (avoh(AvohY,Y), pai(X, AvohY)).
bisavoh(X,Y) :- (avo(AvoY,Y), mae(X, AvoY)) ; (avoh(AvohY,Y), mae(X, AvohY)).

descendente(X, Y) :-
    pai(Y, X) ; mae(Y, X).
descendente(X, Y) :-
    (pai(PaiX, X) ; mae(MaeX, X)), 
    (descendente(PaiX, Y); 
    descendente(MaeX, Y)).

feliz(X) :- pai(X,_) ; mae(X,_).

ascendente(X,Y) :- genitor(X,Y). %recursão - caso base
ascendente(X,Y) :- genitor(X, Z), ascendente(Z, Y). %recursão - passo recursivo
