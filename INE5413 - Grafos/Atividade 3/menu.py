from redeDeFluxo import RedeDeFluxo
from grafoBiPartido import GrafoBiPartido
from grafoColoracao import GrafoColoracao

class Menu:
    def __init__(self, filepath_BiPartido: str = "Arquivo_grafos/pequenoEmparelhamento.net", 
                       filepath_RedeDeFluxo: str = "Arquivo_grafos/testeRede.net",
                       filepath_Coloracao: str = "Arquivo_grafos/cor3.net"):
        
        self.grafo_BiPartido = GrafoBiPartido()
        self.grafo_BiPartido.ler(filepath_BiPartido)
        
        self.grafo_Coloracao = GrafoColoracao()
        self.grafo_Coloracao.ler(filepath_Coloracao)
        
        self.grafo_RedeDeFluxo = RedeDeFluxo()
        self.grafo_RedeDeFluxo.ler(filepath_RedeDeFluxo)

    def mainMenu(self):
        while (1):
            print ("\n########################\n")
            print("Menu:")
            print("1 - Fluxo máximo (por padrão executa 'Arquivo_grafos/testeRede.net')")
            print("2 - Emparelhamento máximo (por padrão executa 'Arquivo_grafos/pequenoEmparelhamento.net')")
            print("3 - Coloração (por padrão executa 'Arquivo_grafos/cor3.net')")
            print("4 - Fechar programa")
            opt = input ("\nSelecione uma opção: ")
            
            if opt == "1":
                self.readGraph(self.grafo_RedeDeFluxo, "Arquivo_grafos/testeRede.net")
                
                s = self.selectGrafoVertice(self.grafo_RedeDeFluxo, 's')
                t = self.selectGrafoVertice(self.grafo_RedeDeFluxo, 't')
                print("\nFluxo Máximo =", self.grafo_RedeDeFluxo.edmond_karp(s,t))
            
            elif opt == "2":
                self.readGraph(self.grafo_BiPartido, "Arquivo_grafos/pequenoEmparelhamento.net")
                self.grafo_BiPartido.hopcroft_karp()

            elif opt == "3":
                self.readGraph(self.grafo_Coloracao, "Arquivo_grafos/cor3.net")
                self.grafo_Coloracao.lawler()
                    
            elif opt == "4":
                break
            
            else:
                print("Opção inválida")

    def selectGrafoVertice(self, grafo, generic_vertice: str = 'v') -> int:
        vertice = input(f"Selecione um vértice {generic_vertice} (1 a {grafo.qtdVertices()}): ")
        if vertice not in grafo.vertices():
            print("Vertice inválido")
            return self.selectGrafoVertice()
        else:
            return vertice 
        
    def readGraph(self, grafo, default_file: str):
        print ("\n########################\n")
        filepath = input("Escreva o nome do arquivo: ")
        try:
            grafo.ler(filepath)
            print("Grafo lido com sucesso")
        except FileNotFoundError as e:
            print(f"Arquivo não encontrado. Usando o arquivo padrão: {default_file}")
            grafo.ler(default_file)
        print()