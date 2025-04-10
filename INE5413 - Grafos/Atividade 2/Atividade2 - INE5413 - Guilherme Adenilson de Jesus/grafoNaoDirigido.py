from grafo import Grafo
from cdElemento import CdElemento, cdEncontra, cdUniao

class GrafoNaoDirigido(Grafo):
    def __init__(self):
        super().__init__()
    
    def setCusto(self, origem: int, destino: int, custo: int):
        self._matriz_adjacencia[origem-1][destino-1] = custo
        self._matriz_adjacencia[destino-1][origem-1] = custo
    
    #Ordenação por QuickSort (adaptado para a classe implementada)
    def ordernar(self, arestas):
        if len(arestas) <= 1:
            return arestas

        (pivo_u, pivo_v) = arestas[-1]
        i = -1

        for j in range(len(arestas)-1):
            u,v = arestas[j]
            if self.peso(u,v) <= self.peso(pivo_u, pivo_v):
                i += 1
                arestas[i], arestas[j] = arestas[j], arestas[i]

        arestas[i+1], arestas[-1] = arestas[-1], arestas[i+1]

        left = self.ordernar(arestas[:i+1])
        right = self.ordernar(arestas[i+2:])

        return left + [arestas[i+1]] + right
    
    def kruskal(self):
        A = []
        S = []
        #Criação de cada vértice-árvore (auxílio de cdElemento visto em aula)
        for v in range(self.qtdVertices()):
            S.append(CdElemento())

        E_linha = self.ordernar(self._arestas) #Ordenação: Quicksort

        for (u,v) in E_linha:
            if cdEncontra(S[u-1]) != cdEncontra(S[v-1]):
                A.append((u,v))
                cdUniao(S[u-1], S[v-1])

        #Impressão 1ª Linha
        print(sum(self.peso(u,v) for (u,v) in A))
        
        #Impressão 2ª Linha
        A_impressao = [f"{u}-{v}" for (u,v) in A]
        print(", ".join(A_impressao))

        return A
            