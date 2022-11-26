%{
	/* C Declarations and Definitions */
	#include "test.tab.h"
	#include <stdio.h>

	extern int yylval;

%}

/* Regular Expression Definitions */
CHAR 		"char"
ELSE		"else"
FOR 		"for"
IF 			"if"
INT 		"int"
RET 		"return"
VOID 		"void"
ID 			[a-zA-Z_][a-zA-Z_0-9]*
INT_CONST 	[+|-]?[0-9]+
CHAR_CONST 	['][^\'\\\n]+[\'\"\?\\\a\b\f\n\r\t\v]*[']
STR_LIT		["][^\"\\\n]*[\'\"\?\\\a\b\f\n\r\t\v]*(\\0)?([^\"\\\n]*[\'\"\?\\\a\b\f\n\r\t\v]*)?["]
PUNC		(\[|\]|\(|\)|\{|\}|&|\*|\+|-|\/|%|!|\?|<|>|=|\:|;|\,)
EQ_OPT			(==)
LE_OPT			(<=)
GE_OPT			(>=)
NE_OPT			(!=)
AND_OPT			(&&)
PTR_OPT			(->)
OR_OPT			(\|\|)
MULTI_COMM	(\/\*)[^(\*\/)]*(\*\/)
SINGLE_COMM (\/\/).*
WS			[\s\t\n]

%%


{VOID} 			{ return VOID; /* Keyword Rule */}
{ELSE} 			{ return ELSE;/* Keyword Rule */ }
{FOR}			{ return FOR; /* Keyword Rule */}
{IF} 			{ return IF; /* Keyword Rule */}
{INT} 			{ return INT; /* Keyword Rule */}
{CHAR} 			{ return CHAR; /*Keyword Rule*/}
{RET} 			{ return RET; /* Keyword Rule */}
{ID}			{ return ID;}
{INT_CONST} 	{ return INT_CONST;}
{CHAR_CONST} 	{ return CHAR_CONST;}
{STR_LIT} 		{ return STR_LIT;} 
{EQ_OPT}		{ return EQ_OPT;}
{LE_OPT}		{ return LE_OPT;}
{GE_OPT}		{ return GE_OPT;}
{NE_OPT}		{ return NE_OPT;}
{AND_OPT}		{ return AND_OPT;}
{PTR_OPT}		{ return PTR_OPT;}
{OR_OPT}		{ return OR_OPT;}
{PUNC} 			{ return yytext[0];}
{MULTI_COMM} 	{ return MULTI_COMM;}
{SINGLE_COMM} 	{ return SINGLE_COMM;}
{WS}        	{ /* White-space Rule */}



%%

