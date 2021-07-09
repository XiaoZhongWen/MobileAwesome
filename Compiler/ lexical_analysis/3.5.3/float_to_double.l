%%
\n { printf("\n"); }
. ECHO;
float { printf("double"); }
%%

int main() {
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}