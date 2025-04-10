from docx import Document
from num2words import num2words
from pathlib import Path
from time import sleep
from docx2pdf import convert
from docxedit import replace_string
import sys
import re


error_log = []

def find_file(filename, search_path):
    search_path = Path(search_path)
    for file in search_path.rglob(filename):
        return 1
    return None

def print_error_log():
    print("\n===========================\nERROS ENCONTRADOS:\n")
    for i in error_log:
        print(i)

def format_day(day):
    value = re.sub(r'\D', '', phone_number)

    return f"{value} ({num2words(value, lang="pt_BR")})"

def format_cash(cash):
    value = re.sub(r'[^\d,]', '', cash)
    # Regex para capturar o formato DDMMYYYY
    patterns = [
        (r"^(\d+),(\d{2})$", r"R$ \1,\2"),
        (r"^(\d+)$", r"R$ \1,00")
    ]

    for pattern, replacement in patterns:
        if re.match(pattern, value):
            return_data = re.sub(pattern, replacement, value)
            number = re.sub(r"^(\d+),(\d{2})", r"\1.\2", value)
            return return_data + f" ({num2words(number, lang="pt_BR")} reais)"

    error_log.append(f"Dinheiro em formato incorreto: {cash}\n")
    return None

def format_phone_number(phone_number):
    value = re.sub(r'\D', '', phone_number)

    patterns = [
        (r"^(\d{2})(\d{4})(\d{4})$", r"\1 \2 \3"),  # XX XXXX XXXX
        (r"^(\d{2})(\d{5})(\d{4})$", r"\1 \2 \3"),  # XX XXXXX XXXX
        (r"^(\d{4})(\d{4})$", r"48 \1 \2"),         # 48 XXXX XXXX
        (r"^(\d{5})(\d{4})$", r"48 \1 \2")          # 48 XXXXX XXXX
    ]

    for pattern, replacement in patterns:
        if re.match(pattern, value):
            return re.sub(pattern, replacement, value)

    error_log.append(f"Telefone em formato incorreto: {phone_number}\n")
    return None

def format_cpf(cpf):
    value = re.sub(r'\D', '', cpf)

    sum = 0

    for i in value:
        sum += int(i)

    if str(sum)[0] != str(sum)[1]:
        error_log.append(f"CPF em formato incorreto: {cpf}, Soma Dígitos = {sum}\n")
        return None

    patterns = [
        (r"^(\d{3})(\d{3})(\d{3})(\d{2})$", r"\1.\2.\3-\4")
    ]

    for pattern, replacement in patterns:
        if re.match(pattern, value):
            return re.sub(pattern, replacement, value)

    error_log.append(f"CPF em formato incorreto: {cpf}\n")
    return None

def format_date(date):
    value = re.sub(r'\D', '', date)
    
    month_names = {
        "01": "janeiro",
        "02": "fevereiro",
        "03": "março",
        "04": "abril",
        "05": "maio",
        "06": "junho",
        "07": "julho",
        "08": "agosto",
        "09": "setembro",
        "10": "outubro",
        "11": "novembro",
        "12": "dezembro",
    }

    # Regex para capturar o formato DDMMYYYY
    pattern = r"^(\d{2})(\d{2})(\d{4})$"
    match = re.match(pattern, value)

    if match:
        day, month, year = match.groups()
        month_name = month_names.get(month, "Mês inválido")
        return f"{day} de {month_name} de {year}"
    else:
        error_log.append(f"Formato de data inválido: {date}")
        return None

parameters = dict()
filepath_parameters = sys.argv[1]
filepath_model = sys.argv[2]
document = Document(filepath_model)

with open(filepath_parameters, 'r', encoding = 'utf-8') as file:
    while True:
        line = file.readline()
        if not line:
            break
        parameter, value = line.split("=")
        value = value.strip()
        if parameter == "NOME":
            value = value.upper()
        if parameter == "TELEFONE":
            value = format_phone_number(value)
        elif parameter == "CPF":
            value = format_cpf(value)
        elif parameter in ["DIA_CONTRATO", "INICIO_ALUGUEL", "FIM_ALUGUEL"]:
            value = format_date(value)
        elif parameter in ["VALOR_ALUGUEL", "VALOR_CAUCAO"]:
            value = format_cash(value)
        elif parameter == "DIA_PAGAMENTO":
            value = format_day(value)

        parameters[parameter] = value
        replace_string(document, old_string=f"[{parameter}]", new_string=value)

print(f"===================")

for i,j in parameters.items():
    print(f"{i} = {j}")

print(f"===================")

if len(error_log) > 0:
    print_error_log()
else:
    document_name = f"Contrato_locacao_{parameters["NOME"].split()[0]}_Casa45.docx"
    document.save(document_name)
    file_path = '/Users/guilh/OneDrive/Documentos/UFSC/Teste Contratos Automatizados'

    file = find_file(document_name, file_path)
    while not file:
        print("BUSCANDO ARQUIVO")
        sleep(2)
        file = find_file(document_name, file_path)
    convert(document_name) #Convertendo para pdf
    print(f"ARQUIVO SALVO EM: C:{file_path}/{document_name}")