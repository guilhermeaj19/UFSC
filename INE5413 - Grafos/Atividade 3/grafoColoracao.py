from grafo import Grafo

class GrafoColoracao(Grafo):
    def __init__(self):
        super().__init__()
    
    def setCusto(self, origem: int, destino: int, custo: int):
        self._matriz_adjacencia[origem-1][destino-1] = custo
        self._matriz_adjacencia[destino-1][origem-1] = custo

    #Retorna uma lista ordernada decrescente pelo tamanho dos elementos
    def ordernar_by_length(self, list):
        if len(list) <= 1:
            return list

        pivo_u = len(list[-1])
        i = -1

        for j in range(len(list)-1):
            u = len(list[j])
            if u >= pivo_u:
                i += 1
                list[i], list[j] = list[j], list[i]

        list[i+1], list[-1] = list[-1], list[i+1]

        left = self.ordernar_by_length(list[:i+1])
        right = self.ordernar_by_length(list[i+2:])

        return left + [list[i+1]] + right

    #Retorna o conjunto potência de um conjunto
    def conjunto_potencia(self, conjunto):
        listsub = list(set(conjunto))
        subsets = []
        for i in range(2 ** len(listsub)):
            subset = []
            for k in range(len(listsub)):
                if i & 1 << k:
                    subset.append(listsub[k])
            subsets.append(subset)
        return subsets
    
    #Retorna o subgrafo do Grafo = (V,E), sendo S um subconjunto de V
    def grafo_linha_lawler(self,S):
        (V, E) = S, []
        for (u,v) in self._arestas:
            if u in S and v in S:
                E.append({u,v})
        return(V,E)

    def PCIM(self, V_, E_):
        U = [frozenset(i) for i in self.ordernar_by_length(self.conjunto_potencia(V_))]
        R = set()
        size_U = len(U)
        size_U_ = 0
        
        for S in U[:]:
            if S in U:
                c = True
                for v in list(S):
                    for u in list(S):
                        if {u,v} in E_ or {v,u} in E_:
                            c = False
                            break
                    if not c:
                        break
                
                if c:
                    sub_conjunto = [frozenset(i) for i in self.ordernar_by_length(self.conjunto_potencia(S))]
                    for conjunto in sub_conjunto:
                        if conjunto in U:
                            U.remove(conjunto)
                    
                    R.add(S)
        return R
   
    def lawler(self):
        
        def busca_indice_tabela(S):
            for key in table.keys():
                if table[key]["S"] == S:
                    return key

        #Criação da tabela de conjuntos e número de cores para cada um
        table = dict()
        U = [frozenset(i) for i in self.conjunto_potencia([i+1 for i in self.vertices()])]
        infinito = float("inf")
        for i in range(2**self.qtdVertices()):
            table[i] = {"S": U[i], "X": infinito}

        table[0]["X"] = 0
        
        for S in U[1:]:
            s = busca_indice_tabela(S)
            (V_,E_) = self.grafo_linha_lawler(S)
            for I in self.PCIM(V_,E_):
                i = busca_indice_tabela(S-I)
                if table[i]["X"] + 1 < table[s]["X"]:
                    table[s]["X"] = table[i]["X"] + 1
        
        last_index = 2**self.qtdVertices()-1
        
        (V_,E_) = self.grafo_linha_lawler(table[last_index]["S"])
    
        vertices = list(self.PCIM(V_,E_))        
        
        #Busca o maior número de conjuntos dijuntos possível
        possiveis_disjuntos = []
        for j in range(len(vertices)+1):
            vertices_para_busca = vertices if j == 0 else vertices[0:j-1] + vertices[j:]
            for i in range(len(vertices)):
                lista_de_disjuntos = []
                for conjunto in sorted(vertices_para_busca[i:], key=len, reverse=True):
                    if not any(conjunto & agrup for agrup in lista_de_disjuntos):
                        lista_de_disjuntos.append(conjunto)
                possiveis_disjuntos.append(lista_de_disjuntos)
        
        #Ordena em decrescente pelo tamanho e pega a lista de conjuntos na primeira posição
        disjuntos = self.ordernar_by_length(possiveis_disjuntos)[0]

        #Atribui as cores
        num_croma = dict()
        for pos, v in enumerate(disjuntos):
            if pos == table[last_index]["X"]:
                break
            for u in v:
                num_croma[u] = pos

        print("Coloração mínima =", table[last_index]["X"])
        keys = list(num_croma.keys())
        keys.sort()
        for vertice in keys:
            print(f"{vertice}: {num_croma[vertice]}")
        
        return table[last_index]["X"]
        