from grafo import Grafo
from a_queue import Queue

class GrafoBiPartido(Grafo):
    def __init__(self):
        super().__init__()
        self.X = []
        
    def setCusto(self, origem: int, destino: int, custo: int):
        self._matriz_adjacencia[origem-1][destino-1] = custo
        self._matriz_adjacencia[destino-1][origem-1] = custo
        if origem not in self.X:
            self.X.append(origem)

    def hopcroft_karp(self):
        distancia = dict()
        mapeamento = dict()
        for v in self.vertices():
            distancia[v+1] = float("inf")
            mapeamento[v+1] = None
        m = 0
        
        while True:
            (is_true, distancia) = self.bfs(mapeamento, distancia)
            if not is_true: break
            for x in self.X:
                if mapeamento[x] == None:
                    (is_true, mapeamento, distancia) = self.dfs(mapeamento,x,distancia)
                    if is_true:
                        m += 1
        
        #Busca as aresta relacionados ao emparelhamento
        emparelhamentos = set()
        for key in mapeamento.keys():
            if mapeamento[key] != None:
                emparelhamentos.add(frozenset([key,mapeamento[key]]))
                
        print(f"Emparelhamento máximo: {m}")
        print(f"Arestas: {' '.join([str(tuple(aresta)) for aresta in emparelhamentos])}")
        return (m, mapeamento)

    def bfs(self, mapeamento, distancia):
        Q = Queue()
        
        for x in self.X:
            if mapeamento[x] == None:
                distancia[x] = 0
                Q.enqueue(x)
            else:
                distancia[x] = float("inf")

        distancia[None] = float("inf")
        
        while Q.isEmpty() == False:
            x = Q.dequeue()
            if distancia[x] < distancia[None]:
                for y in self.vizinhos(x):
                    if distancia[mapeamento[y]] == float("inf"):
                        distancia[mapeamento[y]] = distancia[x] + 1
                        Q.enqueue(mapeamento[y])
    
        return (distancia[None] != float("inf"),distancia)
    
    def dfs(self, mapeamento, x, distancia):
        if x != None:
            for y in self.vizinhos(x):
                if distancia[mapeamento[y]] == distancia[x] + 1:
                    (is_true, mapeamento, distancia) = self.dfs(mapeamento, mapeamento[y], distancia)
                    if is_true:
                        mapeamento[y] = x
                        mapeamento[x] = y
                        return (True, mapeamento, distancia)
            distancia[x] = float("inf")
            return (False, mapeamento, distancia)
        return (True, mapeamento, distancia)