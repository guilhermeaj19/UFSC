
#Arquivo auxiliar para o algoritmo de Kruskal

class CdElemento:
    def __init__(self) -> None:
        self.pai = self
        self.rank = 0
        
def cdLigar(x, y):
    if x.rank > y.rank:
        y.pai = x
    else:
        x.pai = y
        if x.rank == y.rank:
            y.rank += 1
            
def cdEncontra(x):
    if x != x.pai:
        x.pai = cdEncontra(x.pai)
    return x.pai

def cdUniao(x, y):
    cdLigar(cdEncontra(x),cdEncontra(y))