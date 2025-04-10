from grafoNaoDirigido import GrafoNaoDirigido
from grafoDirigido import GrafoDirigido

class Menu:
    def __init__(self, filepath_ND: str = "grafoTeste.net", filepath_D: str = "grafoOrdTop.net"):
        self.grafo_nd = GrafoNaoDirigido()
        self.file_nd = filepath_ND
        self.grafo_nd.ler(filepath_ND)
        self.grafo_d = GrafoDirigido()
        self.file_d = filepath_D
        self.grafo_d.ler(filepath_D)

    def mainMenu(self):
        while (1):
            print ("\n########################\n")
            print("Menu:")
            print("1 - Ler um arquivo de grafo não-dirigido (por padrão é grafoTeste.net)")
            print("2 - Ler um arquivo de grafo dirigido (por padrão é grafoOrdTop.net)")
            print(f"3 - Operações em cima do grafo não-dirigido lido ({self.file_nd})")
            print(f"4 - Operações em cima do grafo dirigido lido ({self.file_d})")
            print("5 - Fechar programa")
            opt = input ("\nSelecione uma opção: ")
            
            if opt == "1":
                print ("\n########################\n")
                filepath = input("Escreva o nome do arquivo: ")
                try:
                    self.grafo_nd.ler(filepath)
                    self.file_nd = filepath
                    print("Grafo lido com sucesso")
                except FileNotFoundError as e:
                    print("Arquivo não encontrado. Usando o arquivo padrão: grafoTeste.net")
                    self.file_nd = "grafoTeste.net"
                    self.grafo_nd.ler(self.file_nd)
            
            elif opt == "2":
                print ("\n########################\n")
                filepath = input("Escreva o nome do arquivo: ")
                try:
                    self.grafo_d.ler(filepath)
                    self.file_d = filepath
                    print("Grafo lido com sucesso")
                except FileNotFoundError as e:
                    print("Arquivo não encontrado. Usando o arquivo padrão: grafoOrdTop.net")
                    self.file_d = "grafoOrdTop.net"
                    self.grafo_d.ler("grafoOrdTop.net")

            elif opt == "3":
                self.nd_operationMenu()
                    
            elif opt == "4":
                self.d_operationMenu()
            
            elif opt == "5":
                break
            
            else:
                print("Opção inválida")
    
    def nd_operationMenu(self):
        while (1):
            print ("\n########################\n")
            print("Operações - Grafo Não Dirigido: ")
            print ("1 - Representação")
            print ("2 - Árvore Geradora Mínima (por Kruskal)")
            print ("3 - Retornar pro menu")
            num_selected = input ("\nSelecione uma opção: ")
            
            print()
            
            if num_selected == "1":
                print ("########################\n")
                self.representationMenu(self.grafo_nd)

            elif num_selected == "2":
                self.grafo_nd.kruskal()
            
            elif num_selected == "3":
                break
           
            else:
                print("Opção inválida")

    def d_operationMenu(self):
        while (1):
            print ("\n########################\n")
            print("Operações - Grafo Dirigido: ")
            print ("1 - Representação")
            print ("2 - Componentes Fortemente Conexas")
            print ("3 - Ordenação topológica")
            print ("4 - Retornar pro menu")
            num_selected = input ("\nSelecione uma opção: ")
            
            print()
            
            if num_selected == "1":
                print ("########################\n")
                self.representationMenu(self.grafo_d)

            elif num_selected == "2":
                self.grafo_d.compFortConec()
            
            elif num_selected == "3":
                self.grafo_d.ordenacao_topologica()
            
            elif num_selected == "4":
                break
           
            else:
                print("Opção inválida")
    
    def representationMenu(self, grafo):
        print("Representação:")
        print("1 - Quantidade de Vértices")
        print("2 - Quantidade de Arestas/Arcos")
        print("3 - Grau de um vértice")
        print("4 - Rótulo de um vértice")
        print("5 - Vizinhos de um vértice")
        print("6 - Há uma aresta/arco (u,v)?")
        print("7 - Peso de uma aresta/arco (u,v)")
        represent_sel = input ("\nSelecione uma opção: ")
        print()
        
        if represent_sel == "1":
            print(f"Quantidade de vértices: {grafo.qtdVertices()}")
        
        elif represent_sel == "2":
            print(f"Quantidade de arestas/arcos: {grafo.qtdArestas()}")
        
        elif represent_sel == "3":
            idx_v = self.selectGrafoVertice(grafo)
            print(f"Grau do vértice {idx_v+1}: {grafo.grau(idx_v)}")
        
        elif represent_sel == "4":
            idx_v = self.selectGrafoVertice(grafo)
            print(f"Rótulo do vértice {idx_v+1}: {grafo.rotulo(idx_v)}")
        
        elif represent_sel == "5":
            idx_v = self.selectGrafoVertice(grafo)
            print(f"Vizinhos do vértice {idx_v+1}: {', '.join([str(x) for x in grafo.vizinhos(idx_v)])}")
        
        elif represent_sel == "6":
            idx_u = self.selectGrafoVertice(grafo, "u")
            idx_v = self.selectGrafoVertice(grafo, "v")
            print(f"Há uma aresta/arco ({idx_u+1}, {idx_v+1})? {grafo.haAresta(idx_u, idx_v)}")
        
        elif represent_sel == "7":
            idx_u = self.selectGrafoVertice(grafo, "u")
            idx_v = self.selectGrafoVertice(grafo, "v")
            if grafo.haAresta(idx_u, idx_v):
                print(f"Peso da aresta/arco ({idx_u+1}, {idx_v+1})? {grafo.peso(idx_u, idx_v)}")
            else:
                print("Aresta/arco não existe. Peso infinito")

        else:
            print("Opção inválida")

    def selectGrafoVertice(self, grafo, generic_vertice: str = 'v') -> int:
        vertice = input(f"Selecione um vértice {generic_vertice} (1 a {grafo.qtdVertices()}): ")
        if vertice not in [str(x) for x in grafo.vertices()]:
            print("Vertice inválido")
            return self.selectGrafoVertice(grafo, generic_vertice)
        else:
            return int(vertice) - 1