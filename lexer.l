%{
	/* definitions */
	#include "y.tab.h"
	#include "string.h"
%}
/* Regular Expression Definitions */
ESC [\'\''\?\\\a\b\f\n\r\t\v]
SL \/\/[^\n\r]+?(?:\*\)|[\n\r])
ML "/*"([^*/]*)"*/"
INTCONST [0]|[+-][1-9][0-9]*|[0-9]+ 
CCONST [']{ESC}|[^'\n\\]+[']
PUNC "["|"]"|"("|")"|"{"|"}"|"&"|"*"|"/"|"%"|"!"|"?"|"<"|">"|":"|";"|"," 
/*|"+"|"-"|"="*/
INT "int"
CHAR "char"
IF "if"
ELSE "else"
RETURN "return"
VOID "void"
FOR "for"
ID [_a-zA-Z][_a-zA-Z0-9]*
CONST {INTCONST}|{CCONST}
SCONST ["]({ESC}|[^"\n\\])+["]
WS [ \t\n]

%%
{INT}        {return INT;}
{CHAR}       {return CHAR;}
{IF}       {return IF;}
{ELSE}       {return ELSE;}
{VOID}       {return VOID;}
{RETURN}       {return RETURN;}
{FOR}       {return FOR;}
{PUNC}      {return PUNC }          
{SL} 		{}
{ML} 		{}             
{ID} 		{yylval.str = yytext; return IDENTIFIER; } //correct? yylval.id = yytext; ADD REST OF YYLVAL ALSO, FIX THOSE
{INTCONST}              {yylval.intval = atoi(yytext); return I_CONSTANT;} 
{CCONST}             { yylval.chval = (yytext); return CONSTANT; } // print constant?? yeah we have to - dhati
{SCONST}                {return STRLIT; }
"&&"                    { return AND_OP; }
"||"					{ return OR_OP; }
"<="					{ return LE_OP; }
">="					{ return GE_OP; }
"=="					{ return EQ_OP; }
"!="					{ return NE_OP; }
"->"					{ return PTR_OP; }
{WS}        			{return 0;} //correct???

%%

int yywrap(){};
