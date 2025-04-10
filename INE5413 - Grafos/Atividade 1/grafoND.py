from a_queue import Queue

class GrafoND:
    def __init__(self):
        self._matriz_adjacencia = dict()
        self._arestas = list()
        self._rotulos = list()
        self._qtd_vertices = 0
        self._qtd_arestas = 0

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
            infinity = float("inf")
            
            for i in range(self._qtd_vertices):
                index_rotulo = linhas_texto[i+1].split() #Coleta indice e rótulo do vertice
                index = index_rotulo[0] #Primeiro elemento = indice
                rotulo = ' '.join(index_rotulo[1:]) #Demais elementos = rotulo
                self._matriz_adjacencia[index] = dict() 
                self._rotulos.append(rotulo)
            
            for u in self.vertices():
                for v in self.vertices():
                    self._matriz_adjacencia[u][v] = infinity #Por padrão, todos os vertices inalcançáveis entre si
            
            index_arestas = self._qtd_vertices+2 #+2 devido *vertices n e *edges
            self._qtd_arestas = len(linhas_texto[index_arestas:-1])
            for aresta in linhas_texto[index_arestas:-1]:
                elementos = (aresta.split())
                
                origem = elementos[0]
                destino = elementos[1]

                #Verificação caso não haja identificação de custo
                if len(elementos) == 3: custo = float(elementos[2])
                else: custo = 0
                
                self._matriz_adjacencia[origem][destino] = custo
                self._matriz_adjacencia[destino][origem] = custo
                self._arestas.append((origem,destino))
                
    def buscaEmLargura(self, vertice_s: str):
        vertice_s = str(vertice_s)
        conhecido, distancia, antecessor = dict(), dict(), dict() 
        for vertice in self.vertices():
            conhecido[vertice] = False
            distancia[vertice] = float("inf")
            antecessor[vertice] = None
        
        conhecido[vertice_s] = True
        distancia[vertice_s] = 0
        niveis = dict()
        niveis[0] = [vertice_s]
        fila = Queue()
        fila.enqueue(vertice_s)
        
        while (not fila.isEmpty()):
            u = fila.dequeue()
            for v in self.vizinhos(u):
                if (not conhecido[v]):
                    conhecido[v] = True
                    distancia[v] = distancia[u] + 1
                    
                    if distancia[v] not in niveis.keys():
                        niveis[distancia[v]] = [v]
                    else:
                        niveis[distancia[v]].append(v)
                        
                    antecessor[v] = u
                    fila.enqueue(v)

        for nivel in niveis.keys():
            print(f"{nivel}: {','.join(niveis[nivel])}")

        return (distancia, antecessor)
        
    def esCicloEuleriano(self):
        conhecida = dict()
        for aresta in self._arestas:
            conhecida[aresta] = False

        vertice_v = self._arestas[0][0]

        (R, ciclo) = self.buscaCiclo(vertice_v, conhecida)
        
        if not R:
            print(0)
            return (False, None)
        else:
            if sum(conhecida.values()) < self._qtd_arestas:
                print(0)
                return (False, None)
            else:
                print(1)
                print(','.join(ciclo))
                return (True, ciclo)
    
    def buscaCiclo(self, vertice_v: str, conhecida: dict):
        ciclo = [vertice_v]
        vertice_t = vertice_v
        while True:
            #Verificando vizinhos disponíveis com arestas não conhecidas ainda
            vizinhos_de_v = self.vizinhos(vertice_v)
            haVizinhoDisponivel = False
            for vizinho in vizinhos_de_v:
                if (vizinho, vertice_v) in conhecida.keys() and not conhecida[(vizinho, vertice_v)]:
                    haVizinhoDisponivel = True
                    break
                elif (vertice_v, vizinho) in conhecida.keys() and not conhecida[(vertice_v, vizinho)]:
                    haVizinhoDisponivel = True
                    break
            
            if not haVizinhoDisponivel:
                return (False, None)
            else:
                for aresta in self._arestas:
                    if (vertice_v in aresta and not conhecida[aresta]):
                        #Removendo o vertice_v da aresta e mantendo apenas vertice_u
                        vertice_u = list(aresta)
                        vertice_u.remove(vertice_v)
                        vertice_u = vertice_u[0]
                        
                        conhecida[aresta] = True
                        vertice_v = vertice_u
                        ciclo.append(vertice_v)
                        break
            if vertice_v == vertice_t: break

        #Encontrando vertices x que estão no ciclo, mas com arestas desconhecidas
        vertices_x = []
        for vertice in ciclo:
            for aresta in self._arestas:
                if (vertice in aresta and not conhecida[aresta] and vertice not in vertices_x):
                    vertices_x.append(vertice)
            
        for x in vertices_x:
            (R, ciclo_) = self.buscaCiclo(x, conhecida)
            if not R:
                return (False, None)

            for indice in range(len(ciclo)):
                if ciclo[indice] == x:
                    #Unindo os ciclos por concatenação
                    ciclo = ciclo[:indice] + ciclo_ + ciclo[indice+1:]
                    break
 
        return (True, ciclo)

    def bellman_ford(self, vertice_s: str):
        #Inicialização
        vertice_s = str(vertice_s)
        distancia, antecessor = dict(), dict()
        for vertice in self.vertices():
            distancia[vertice] = float("inf")
            antecessor[vertice] = None

        distancia[vertice_s] = 0

        #Relaxamento
        for i in range(self._qtd_vertices - 1):
            for (u,v) in self._arestas:
                #Aresta saindo de u para v
                if distancia[v] > distancia[u] + self._matriz_adjacencia[u][v]:
                    distancia[v] = distancia[u] + self._matriz_adjacencia[u][v]
                    antecessor[v] = u
                #Aresta saindo de v para u
                if distancia[u] > distancia[v] + self._matriz_adjacencia[v][u]:
                    distancia[u] = distancia[v] + self._matriz_adjacencia[v][u]
                    antecessor[u] = v
        
        #Verificando caminhos negativos
        for (u,v) in self._arestas:
            if distancia[u] > distancia[v] + self._matriz_adjacencia[u][v]:
                return (False, None, None)
            if distancia[v] > distancia[u] + self._matriz_adjacencia[v][u]:
                return (False, None, None)
        
        #Printandos os caminhos do vertice s a cada vertice do grafo
        for vertice in self.vertices():
            pai = antecessor[vertice]
            caminho = [vertice]
            
            #Criando o caminho
            while (pai != None):
                caminho.insert(0,pai)
                pai = antecessor[pai]

            print(f"{vertice}: {','.join(caminho)}; d={distancia[vertice]}")

        return (True, distancia, antecessor)
    
    def floyd_warshall(self):
        #Criando as matrizes de distancia e antecessor base
        matriz_distancia = dict()
        matriz_antecessor = dict()
        for u in self.vertices():
            matriz_distancia[u] = dict()
            matriz_antecessor[u] = dict()
            for v in self.vertices():
                matriz_distancia[u][v] = float("inf")
                matriz_antecessor[u][v] = None

        #Reatribuindo valores relevantes
        for u in self.vertices():
            for v in self.vertices():
                matriz_distancia[u][v] = self._matriz_adjacencia[u][v]
                if (u,v) in self._arestas:
                    matriz_antecessor[u][v] = u
                    matriz_antecessor[v][u] = v
            matriz_distancia[u][u] = 0
        
        #Relaxamento
        for k in self.vertices():
            for u in self.vertices():
                for v in self.vertices():
                    if matriz_distancia[u][v] > matriz_distancia[u][k] + matriz_distancia[k][v]:
                        matriz_distancia[u][v] = matriz_distancia[u][k] + matriz_distancia[k][v]
                        matriz_antecessor[u][v] = matriz_antecessor[k][v]
        
        #Printando distancias
        for vertice in self.vertices():
            distancias = [str(d) for d in matriz_distancia[vertice].values()]
            print(f"{vertice}: {','.join(distancias)}")
        return (matriz_distancia, matriz_antecessor)
