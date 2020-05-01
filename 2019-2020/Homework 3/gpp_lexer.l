%{ 
#include <stdio.h>
#include <ctype.h> 
#include "y.tab.h"
%} 

ZERO [0]

DIGIT [0-9]

IDENTIFIER [a-z][a-z0-9]*

RETURN_LIST list
RETURN_APPEND append
RETURN_AND and
RETURN_OR or
RETURN_NOT not
RETURN_EQUAL equal
RETURN_DEFFUN deffun
RETURN_FOR for 
RETURN_CONCAT concat
RETURN_SET set
RETURN_LESS less
RETURN_NIL nil
RETURN_TRUE true
RETURN_FALSE false
RETURN_LOAD load
RETURN_DISP disp
RETURN_IF if
RETURN_EXIT exit


COMMAND \;{2}[a-zA-Z0-9.+-/* ]*


%%

{RETURN_AND}          { return KW_AND; }
{RETURN_OR}           { return KW_OR; }
{RETURN_NOT}          { return KW_NOT; }
{RETURN_LIST}         { return KW_LIST; }
{RETURN_DISP}         { return KW_DISP; }
{RETURN_LOAD}         { return KW_LOAD; }
{RETURN_FALSE}        { return KW_FALSE; }
{RETURN_EQUAL}        { return KW_EQUAL; }
{RETURN_LESS}         { return KW_LESS; }
{RETURN_IF}           { return KW_IF; }
{RETURN_EXIT}         { return KW_EXIT; }
{RETURN_NIL}          { return KW_NIL; }
{RETURN_TRUE}         { return KW_TRUE; }
{RETURN_APPEND}       { return KW_APPEND; }
{RETURN_CONCAT}       { return KW_CONCAT; }
{RETURN_SET}          { return KW_SET; }
{RETURN_DEFFUN}       { return KW_DEFFUN; }
{RETURN_FOR}          { return KW_FOR; }



{ZERO}				{return VALUE; }
{COMMAND}			{return COMMENT; }



{IDENTIFIER}		{return IDENTIFIER;}


"+"					{return OP_PLUS;}
"-"					{return OP_MINUS;}
"/"					{return OP_DIV;}
"*"					{return OP_MULT;}
"**"				{return OP_DBLMULT;}
"("					{return OP_OP;}
")"					{return OP_CP;}
","					{return OP_COMMA;}
"\""				{return OP_OC;}


{DIGIT}+ 			{return VALUE; }
{DIGIT}+"."{DIGIT}*	{return VALUE; }

%% 

int yywrap(){} 
//* int main(){ 
//*
//*	FILE *fp; 
//*	fp = fopen("input.g++","r"); 
//*	yyin = fp;  
//*
//*	yylex(); 
//*	return 0; 
//* } 