import heapq

class No:
    def __init__(self, nome, custo_g=0, custo_h=0, pai=None):
        self.nome = nome
        self.custo_g = custo_g  # Custo acumulado
        self.custo_h = custo_h  # Heurística estimada
        self.pai = pai
        self.custo_f = custo_g + custo_h  # Função de custo total

    def __lt__(self, outro):
        return self.custo_f < outro.custo_f

def imprimir_arvore(no, nivel=0):
    if no:
        print(" " * (nivel * 4) + f"{no.nome} (g={no.custo_g}, h={no.custo_h}, f={no.custo_f})")
        if no.pai:
            imprimir_arvore(no.pai, nivel + 1)

def a_estrela(inicio, objetivo, grafo, heuristica):
    aberto = []
    fechado = set()
    heapq.heappush(aberto, No(inicio, custo_g=0, custo_h=heuristica[inicio]))

    while aberto:
        print("\nLista de abertos:", [f'{n.nome} ({n.custo_g} + {n.custo_h} = {n.custo_f})' for n in aberto])
        print("\nLista de fechados:", [f'{n}' for n in sorted(list(fechado))])
        no_atual = heapq.heappop(aberto)
        print(f"Expandindo nó: {no_atual.nome} (f={no_atual.custo_f})")

        if no_atual.nome == objetivo:
            print("\nÁrvore de busca:")
            imprimir_arvore(no_atual)
            caminho = []
            while no_atual:
                caminho.append(no_atual.nome)
                no_atual = no_atual.pai
            return caminho[::-1]

        fechado.add(no_atual.nome)

        for vizinho, custo in grafo[no_atual.nome].items():
            if vizinho in fechado:
                continue

            custo_g = no_atual.custo_g + custo
            custo_h = heuristica[vizinho]
            novo_no = No(vizinho, custo_g, custo_h, no_atual)

            heapq.heappush(aberto, novo_no)

    return None

# Exemplo de uso:
grafo = {
    'A': {'B': 73 , 'C': 64 , 'D': 89, 'E': 104},
    'B': {'A': 73 , 'C': 83 },
    'C': {'A': 64 , 'I': 64 },
    'D': {'A': 89 , 'N': 89 },
    'E': {'A': 104, 'J': 40 },
    'F': {'I': 31 , 'N': 84 },
    'G': {'J': 35 , 'Q': 113},
    'H': {'K': 35 , 'L': 36 },
    'I': {'C': 64 , 'F': 31 , 'L': 28 , 'M': 20},
    'J': {'E': 40 , 'G': 35 , 'N': 53 , 'Q': 80},
    'K': {'B': 83 , 'H': 35 },
    'L': {'H': 36 , 'I': 28 , 'P': 63},
    'M': {'I': 20 , 'O': 50 },
    'N': {'D': 89 , 'F': 84 , 'J': 53},
    'O': {'M': 50 , 'P': 41, 'R': 72},
    'P': {'L': 63 , 'O': 41, 'R': 65},
    'Q': {'G': 113, 'J': 80, 'R': 65},
    'R': {'O': 72 , 'P': 65, 'Q': 65}
}

# Heurística baseada na tabela do exercício
heuristica = {
    'A': 240, 'B': 186, 'C': 182, 'D': 163, 'E': 170,
    'F': 150, 'G': 165, 'H': 139, 'I': 120, 'J': 130,
    'K': 122, 'L': 104, 'M': 100, 'N': 77, 'O': 72,
    'P': 65, 'Q': 65, 'R': 0
}

caminho = a_estrela('A', 'R', grafo, heuristica)
print("\nCaminho encontrado:", caminho)
