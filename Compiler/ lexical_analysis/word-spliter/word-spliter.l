%{
	#define T_WORD 1
	int numChars = 0, numWords = 0, numLines = 0;
%}

WORD ([^ \t\n\r\a]+)

%%
\n { numChars++; numLines++; }
{WORD} { numWords++; numChars += yyleng; return T_WORD; }
<<EOF>> { return 0; }
. { numChars++; }
%%

int main() {
	int token_type = -1;
	printf("begin token_type:\t%d, token:%s\n", token_type, yytext);
	while( (token_type = yylex()) ) {
		; printf("WORD:\t%s\n", yytext);
		printf("token_type:\t%d, token:%s\n", token_type, yytext);
	}
	printf("end token_type:\t%d, token:%s\n", token_type, yytext);
	printf("\nChars=%d, Words=%d, Lines=%d\n", numChars, numWords, numLines);
	return 0;
}

int yywrap() {
	return 1;
}

