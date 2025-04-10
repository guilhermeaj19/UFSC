#include <stdio.h>
#include <string.h>

int main (int argc, char **argv) {
	FILE *f;
	char string[256];

	if((f = fopen("teste.txt",	"a+")) == NULL) {
		printf("Erro ao abrir arquivo\n");
		return 1;
	}

	do {
     	fgets(string, 256, stdin);
     	fputs(string, f);
	} while(string[0] != '\n');

	rewind(f);

	while (fgets(string, 256, f) != NULL)		
		fputs(string, stdout);

	fclose(f);
	return 0;
}