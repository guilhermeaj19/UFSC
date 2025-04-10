from a_queue import Queue
from copy import deepcopy

class RedeDeFluxo:
    def __init__(self):
        self._matriz_adjacencia = dict()
        self._arestas = list()
        self._rotulos = list()
        self._qtd_vertices = 0
        self._qtd_arestas = 0
        
    def setCusto(self,origem, destino, custo):
        self._matriz_adjacencia[origem][destino] = custo

    def qtdVertices(self):
        return self._qtd_vertices
    
    def vertices(self):
        return self._matriz_adjacencia.keys()

    def qtdArestas(self):
        return self._qtd_arestas

    def grau(self, index_vertice: str):
        #Garantindo que o indice é uma string
        index_vertice = str(index_vertice)

        grau_vertice = 0
        infinity = float("inf")
        for v in self._matriz_adjacencia[index_vertice].values():
            if v < infinity:
                grau_vertice += 1
        
        return grau_vertice

    def rotulo(self, index_vertice: str):
        #Garantindo que o indice é uma string
        index_vertice = str(index_vertice)
        return (self._rotulos[int(index_vertice)-1])
    
    def vizinhos(self, index_vertice: str):
        #Garantindo que o indice é uma string
        index_vertice = str(index_vertice)

        vizinhos_do_vertice = []
        vertices = self._matriz_adjacencia[index_vertice]
        
        infinity = float("inf")
        
        for v in vertices.keys():
            if vertices[v] < infinity:
                vizinhos_do_vertice.append(v)

        return vizinhos_do_vertice
    
    def haAresta(self, idx_vertice1: str, idx_vertice2: str):
        return (self._matriz_adjacencia[str(idx_vertice1)][str(idx_vertice2)] < float("inf"))
    
    def peso(self, idx_vertice1: str, idx_vertice2: str):
        return (self._matriz_adjacencia[str(idx_vertice1)][str(idx_vertice2)])
    
    def ler(self, nome_arquivo: str):
        #Resetando caso já houvesse um grafo lido
        self._matriz_adjacencia = dict()
        self._arestas = list()
        self._rotulos = list()
        self._qtd_vertices = 0
        self._qtd_arestas = 0

        with open(file = nome_arquivo) as file:
            linhas_texto = file.read().split("\n")
            self._qtd_vertices = int(linhas_texto[0].split()[1]) #Primeira linha *vertices n, pega o valor n
            
            for i in range(self._qtd_vertices):
                index_rotulo = linhas_texto[i+1].split() #Coleta indice e rótulo do vertice
                index = index_rotulo[0] #Primeiro elemento = indice
                rotulo = ' '.join(index_rotulo[1:]) #Demais elementos = rotulo
                self._matriz_adjacencia[index] = dict() 
                self._rotulos.append(rotulo)
            
            for u in self.vertices():
                for v in self.vertices():
                    self._matriz_adjacencia[u][v] = 0 #Por padrão, todos os vertices inalcançáveis entre si
            
            index_arestas = self._qtd_vertices+2 #+2 devido *vertices n e *edges
            self._qtd_arestas = len(linhas_texto[index_arestas:-1])
            for aresta in linhas_texto[index_arestas:]:
                if len(aresta) < 2: break
                elementos = (aresta.split())
                
                origem = elementos[0]
                destino = elementos[1]

                #Verificação caso não haja identificação de custo
                if len(elementos) == 3: custo = float(elementos[2])
                else: custo = 0
                
                self.setCusto(origem, destino, custo)
                self._arestas.append((origem,destino))
    
    # Adiciona um novo vértice
    def add_dummy_vertex(self,v):
        if v not in self.vertices():
            self._qtd_vertices += 1
            vertices = self.vertices()
            for i in vertices:
                self._matriz_adjacencia[i][v] = 0
            
            self._matriz_adjacencia[v] = dict()
            for i in self.vertices():
                self._matriz_adjacencia[v][i] = 0
            return 1
        return 0
  
    #Adiciona uma aresta dummy u->u'->v
    def add_dummy_edge(self,u,v):
        if (u,v) not in self._arestas:
            print("Aresta inexistente")
            return
        if u not in self.vertices() or v not in self.vertices():
            print("INDEX ERRADO")
            return
        
        dummy = u+"_"
        self.add_dummy_vertex(dummy)

        self._matriz_adjacencia[u][dummy] = self.peso(u,v)
        self._matriz_adjacencia[dummy][v] = self.peso(u,v)
        self._matriz_adjacencia[u][v] = 0
        self._arestas.append((u,dummy))
        self._arestas.append((dummy,v))
        self._arestas.remove((u,v))
        self._qtd_arestas += 1
    
    # Converte a rede de fluxo em rede residual
    def convert_to_residual(self):
        vertices = list(self.vertices())
        for u in vertices:
            for v in vertices:
                if self.peso(u,v) != 0 and self.peso(v,u) != 0:
                    self.add_dummy_edge(u,v)
    
    def edmond_karp(self, s, t):
        # Faz a cópia e converte para Rede Residual para preservar o reuso da Rede de Fluxo
        rede_residual = deepcopy(self)
        rede_residual.convert_to_residual()

        F = 0
        while True:
            p = rede_residual.busca_CA(s,t)
            
            if not p: break #Se p tem valor nulo, não há mais CA
            
            fp = float("inf")
            #Busca a menor capacidade no caminho
            for i in range(len(p)-1):
                if rede_residual.peso(p[i],p[i+1]) < fp:
                    fp = rede_residual.peso(p[i], p[i+1])

            F += fp
            
            #Atualiza valores de capacidade
            for i in range(len(p)-1):
                u = p[i]
                v = p[i+1]
                rede_residual._matriz_adjacencia[u][v] -= fp
                rede_residual._matriz_adjacencia[v][u] += fp

        return F
    
    def busca_CA(self, s, t):
        C = dict()
        A = dict()
        
        for v in self.vertices():
            C[v] = False
            A[v] = None
        
        C[s] = True
        Q = Queue()
        Q.enqueue(s)
        while not Q.isEmpty():
            u = Q.dequeue()
            for v in self.vizinhos(u):
                if not C[v] and self.peso(u,v) > 0:
                    C[v] = True
                    A[v] = u
                    if v == t:
                        p = [t]
                        w = t
                        while w != s:
                            w = A[w]
                            p.insert(0,w)
                        return p
                    Q.enqueue(v)
        return None
