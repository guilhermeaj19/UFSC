#Classe pai que implementa as funções de representação de um grafo
#As classes filhas devem implementar o método "setCusto"

class Grafo:
    def __init__(self):
        self._matriz_adjacencia = list()
        self._arestas = list()
        self._rotulos = list()
        self._qtd_vertices = 0
        self._qtd_arestas = 0

    def qtdVertices(self):
        return self._qtd_vertices
    
    def vertices(self):
        return list(range(self._qtd_vertices))

    def qtdArestas(self):
        return self._qtd_arestas

    def grau(self, index_vertice: int):
        #Garantindo que o indice é uma string
        grau_vertice = 0
        infinity = float("inf")
        for v in self._matriz_adjacencia[index_vertice-1]:
            if v < infinity:
                grau_vertice += 1
        
        return grau_vertice

    def rotulo(self, index_vertice: int):
        return (self._rotulos[int(index_vertice)-1])
    
    def vizinhos(self, index_vertice: int):

        vizinhos_do_vertice = []
        vertices = self._matriz_adjacencia[index_vertice-1]
        infinity = float("inf")
        
        for pos, v in enumerate(vertices):
            if v < infinity:
                vizinhos_do_vertice.append(pos+1)

        return vizinhos_do_vertice
    
    def haAresta(self, idx_vertice1: int, idx_vertice2: int):
        return (self._matriz_adjacencia[idx_vertice1-1][idx_vertice2-1] < float("inf"))
    
    def peso(self, idx_vertice1: int, idx_vertice2: int):
        return (self._matriz_adjacencia[idx_vertice1-1][idx_vertice2-1])
    
    def ler(self, nome_arquivo: str):
        #Resetando caso já houvesse um grafo lido
        self._matriz_adjacencia = list()
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
                self._matriz_adjacencia.append(list())
                self._rotulos.append(rotulo)
            
            for u in self.vertices():
                for v in self.vertices():
                    self._matriz_adjacencia[u-1].append(infinity)#Por padrão, todos os vertices inalcançáveis entre si
            
            index_arestas = self._qtd_vertices+2 #+2 devido *vertices n e *edges
            self._qtd_arestas = len(linhas_texto[index_arestas:-1])
            for aresta in linhas_texto[index_arestas:-1]:
                elementos = (aresta.split())
                
                origem = elementos[0]
                destino = elementos[1]

                #Verificação caso não haja identificação de custo
                if len(elementos) == 3: custo = float(elementos[2])
                else: custo = 0

                self.setCusto(int(origem), int(destino), custo)
                self._arestas.append((int(origem),int(destino)))

    def setCusto(self, origem: str, destino: str, custo: int):
        pass