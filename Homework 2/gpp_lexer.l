%{ 
#include <stdio.h>
#include <ctype.h> 
%} 

ZERO [0]
ERRORVALUE [0][0-9]*
DIGIT [0-9]

IDENTIFIER [a-z][a-z0-9]*
KEYWORDS and|or|not|equal|less|nil|list|append|concat|set|deffun|for|if|exit|load|disp|true|false

COMMAND \;{2}[a-zA-Z0-9.+-/* ]*


%%

{ZERO}				{printf("VALUE\n");}
{COMMAND}			{printf("COMMENT\n");}
{KEYWORDS}			{
						int i=0,j=3;
						char s[100];
						s[0] = 'K';
						s[1] = 'W';
						s[2] = '_';
						while(sizeof(yytext)>i)
						{
							s[j] = toupper(yytext[i]);
							i++;
							j++;
						}
						printf("%s\n", s);
					} 
{IDENTIFIER}		{printf("IDENTIFIER\n");}
{ERRORVALUE}		{printf("SYNTAX ERROR. Value can not start with 0.\n");
					return 0;} 

"+"					{printf("OP_PLUS\n");}
"-"					{printf("OP_MINUS\n");}
"/"					{printf("OP_DIV\n");}
"*"					{printf("OP_MULT\n");}
"**"				{printf("OP_DBLMULT\n");}
"("					{printf("OP_OP\n");}
")"					{printf("OP_CP\n");}
","					{printf("OP_COMMA\n");}
"\""				{printf("OP_OC\n");}


{DIGIT}+ 			{printf("VALUE\n");}
{DIGIT}+"."{DIGIT}*	{printf("VALUE\n");}

%% 

int yywrap(){} 
int main(){ 

	FILE *fp; 
	fp = fopen("input.g++","r"); 
	yyin = fp;  

	yylex(); 
	return 0; 
} 