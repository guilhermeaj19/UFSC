#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {
  
  if(argc < 2)
    return 1;
  
  FILE *arquivo;
  char str[256];
  
  arquivo = fopen("arquivo_texto.txt", "wb+");
  
  printf("Escrita: '%s' (%lu caracteres)\n", argv[1], strlen(argv[1]));
  fwrite(argv[1], sizeof(char), strlen(argv[1]), arquivo);
  
  fseek(arquivo, 0, SEEK_SET);
  fread(str, sizeof(char), strlen(argv[1]), arquivo);
  printf("Leitura: '%s' (%lu caracteres)\n", str, strlen(str));
  
  fclose(arquivo);
  
  return 0;
}