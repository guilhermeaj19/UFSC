from grafoNaoDirigido import GrafoND

class Menu:
    def __init__(self, filepath: str = "grafoTeste.net"):
        self.grafo = GrafoND()
        self.grafo.ler(filepath)

    def mainMenu(self):
        while (1):
            print ("\n########################\n")
            print("Menu:")
            print("1 - Ler um arquivo de grafo (por padrão é grafoTeste.net)")
            print("2 - Operações em cima do grafo lido")
            print("3 - Fechar programa")
            opt = input ("\nSelecione uma opção: ")
            
            if opt == "1":
                print ("\n########################\n")
                filepath = input("Escreva o nome do arquivo: ")
                try:
                    self.grafo.ler(filepath)
                    print("Grafo lido com sucesso")
                except FileNotFoundError as e:
                    print("Arquivo não encontrado. Usando o arquivo padrão: grafoTeste.net")
                    self.grafo.ler("grafoTeste.net")

            elif opt == "2":
                self.operationMenu()
                    
            elif opt == "3":
                break
            
            else:
                print("Opção inválida")
    
    def operationMenu(self):
        while (1):
            print ("\n########################\n")
            print("Operações: ")
            print ("1 - Representação")
            print ("2 - Busca em Largura")
            print ("3 - Ciclo Euleriano")
            print ("4 - Bellman-Ford")
            print ("5 - Floyd-Warshall")
            print ("6 - Retornar pro menu")
            num_selected = input ("\nSelecione uma opção: ")
            
            print()
            
            if num_selected == "1":
                print ("########################\n")
                self.representationMenu()

            elif num_selected == "2":
                vertice = self.selectGrafoVertice()
                print()
                self.grafo.buscaEmLargura(vertice)
            
            elif num_selected == "3":
                print("Há um ciclo euleriano? (0 se não, 1 se sim, mostrando o ciclo)")
                self.grafo.esCicloEuleriano()
            
            elif num_selected == "4":
                vertice = self.selectGrafoVertice()
                print()
                self.grafo.bellman_ford(vertice)
            
            elif num_selected == "5":
                self.grafo.floyd_warshall()
            
            elif num_selected == "6":
                break
            
            else:
                print("Opção inválida")
    
    def representationMenu(self):
        print("Representação:")
        print("1 - Quantidade de Vértices")
        print("2 - Quantidade de Arestas")
        print("3 - Grau de um vértice")
        print("4 - Rótulo de um vértice")
        print("5 - Vizinhos de um vértice")
        print("6 - Há uma aresta (u,v)?")
        print("7 - Peso de uma aresta (u,v)")
        represent_sel = input ("\nSelecione uma opção: ")
        print()
        
        if represent_sel == "1":
            print(f"Quantidade de vértices: {self.grafo.qtdVertices()}")
        
        elif represent_sel == "2":
            print(f"Quantidade de arestas: {self.grafo.qtdArestas()}")
        
        elif represent_sel == "3":
            idx_v = self.selectGrafoVertice()
            print(f"Grau do vértice {idx_v}: {self.grafo.grau(idx_v)}")
        
        elif represent_sel == "4":
            idx_v = self.selectGrafoVertice()
            print(f"Rótulo do vértice {idx_v}: {self.grafo.rotulo(idx_v)}")
        
        elif represent_sel == "5":
            idx_v = self.selectGrafoVertice()
            print(f"Vizinhos do vértice {idx_v}: {', '.join(self.grafo.vizinhos(idx_v))}")
        
        elif represent_sel == "6":
            idx_u = self.selectGrafoVertice("u")
            idx_v = self.selectGrafoVertice("v")
            print(f"Há uma aresta ({idx_u}, {idx_v})? {self.grafo.haAresta(idx_u, idx_v)}")
        
        elif represent_sel == "7":
            idx_u = self.selectGrafoVertice("u")
            idx_v = self.selectGrafoVertice("v")
            if self.grafo.haAresta(idx_u, idx_v):
                print(f"Peso da aresta ({idx_u}, {idx_v})? {self.grafo.peso(idx_u, idx_v)}")
            else:
                print("Aresta não existe. Peso infinito")

        else:
            print("Opção inválida")

    def selectGrafoVertice(self, generic_vertice: str = 'v') -> int:
        vertice = input(f"Selecione um vértice {generic_vertice} (1 a {self.grafo.qtdVertices()}): ")
        if vertice not in self.grafo.vertices():
            print("Vertice inválido")
            return self.selectGrafoVertice()
        else:
            return vertice 