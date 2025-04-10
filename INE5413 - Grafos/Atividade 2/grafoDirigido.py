import numpy as np
from grafo import Grafo

class GrafoDirigido(Grafo):
    def __init__(self):
        super().__init__()
    
    #Cria o grafo dirigido transposto (auxílio da biblioteca numpy)
    def getTransposto(self):
        grafo_t = GrafoDirigido()
        
        grafo_t._matriz_adjacencia = np.array(self._matriz_adjacencia).T
        grafo_t._qtd_vertices = self._qtd_vertices
        return grafo_t

    def setCusto(self, origem: int, destino: int, custo: int):
        self._matriz_adjacencia[origem-1][destino-1] = custo

    #Componentes fortemente conexas
    def compFortConec(self):
        (C, T, A, F) = self.dfs(self.vertices())
        grafoTransposto = self.getTransposto()
        (C_t, T_t, A_t, F_t) = grafoTransposto.dfs(F)
        
        #Conversão da árvore para imprimir o resultado
        arvore_copia = A_t[:]
        cfcs = list()
        for v, antecessor in enumerate(A_t):
            if antecessor == None:
                cfcs.append([v+1])
                arvore_copia.remove(None)

        for cfc in cfcs:
            v = cfc[-1]
            while(v in arvore_copia):
                cfc.append(A_t.index(cfc[-1])+1)
                arvore_copia.remove(v)
                v = cfc[-1]
            print(",".join([str(x) for x in cfc])) #Imprime uma componente fortemente conexa

        return A_t

    def dfs(self, ordem_visita: list):
        c, t, a, f  = list(), list(), list(), list() #F funciona como pilha
        
        for i in range(self.qtdVertices()):
            c.append(False)
            t.append(float("inf"))
            a.append(None)
        
        tempo = 0
        for u in ordem_visita:
            if c[u] == False:
                (c, t, a, f, tempo) = self.dfs_visit(u, c, t, a, f, tempo) #Retorno porque o python só faz referência em casos específicos
        
        return (c, t, a, f)
    
    def dfs_visit(self, v, c, t, a, f, tempo):
        c[v] = True
        tempo += 1
        t[v] = tempo

        for u in self.vizinhos(v+1):
            if c[u-1] == False:
                a[u-1] = v+1
                (c, t, a, f, tempo) = self.dfs_visit(u-1, c, t, a, f, tempo) #Retorno porque o python só faz referência em casos específicos
        
        tempo += 1
        f.insert(0, v) #Insere na pilha
        return (c, t, a, f, tempo)

    def ordenacao_topologica(self):
        conhecida = [False]*self.qtdVertices()
        ord_top = list()
        for u in self.vertices():
            if conhecida[u] == False:
                ord_top, conhecida = self.visita_ot(u, ord_top, conhecida)
        print(" → ".join([self.rotulo(x) for x in ord_top]) + ".") #Impressão do resultado
        return ord_top

    def visita_ot(self, v, ord_top, conhecida):
        conhecida[v] = True
        for u in self.vizinhos(v+1):
            if conhecida[u-1] == False:
                ord_top, conhecida = self.visita_ot(u-1, ord_top, conhecida) #Retorno porque o python só faz referência em casos específicos
        ord_top.insert(0, v+1)
        return ord_top, conhecida