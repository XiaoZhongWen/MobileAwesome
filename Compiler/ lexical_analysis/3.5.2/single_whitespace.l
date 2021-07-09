SPACE ([ |\t]+)

%%
\n { printf("\n"); }
{SPACE} { printf(" "); }
. ECHO;
%%

int main() {
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}