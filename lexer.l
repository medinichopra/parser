%{
	/* C Declarations and Definitions */
%}
/* Regular Expression Definitions */
CHAR "char"
IF "if"
ELSE "else"
RETURN "return"
VOID "void"
FOR "for"
ID [_a-zA-Z][_a-zA-Z0-9]*
INTCONST [0]|[+-][1-9][0-9]*|[0-9]+ 
ESC [\'\''\?\\\a\b\f\n\r\t\v]
ANYMEM1 [^'\n\\]
ANYMEM2 [^"\n\\]
CCHAR {ESC}|{ANYMEM1}
SCHAR {ESC}|{ANYMEM2}
CCONST '{CCHAR}+'
SCONST ["]{SCHAR}+["]
SL \/\/[^\n\r]+?(?:\*\)|[\n\r])
ML "/*"([^*/]*)"*/"
WS [ \t\n]
/* Definitions of Rules \& Actions */
%%
"int"       { return INT; }
{CHAR}       { return KEYWORD; }
{IF}       { return KEYWORD; }
{ELSE}       { return KEYWORD; }
{VOID}       { return KEYWORD; }
{RETURN}       { return KEYWORD; }
{FOR}       { return KEYWORD; }
{INTCONST} { yylval.num = atoi(yytext); return NUMBER; }
{CCONST} { yylval.ch = yytext; return CONSTANT; }
{SCONST} { yylval.s = yytext; return STRINGLIT}
{ID}        { yyval.id = yytext; return IDENTIFIER; }
{SL} /* Single line Comment Rule */ ;
{ML} /* Multi line Comment Rule */ ;
"[" { return PUNC; }
"]" { return PUNC; }
"(" { return PUNC; }
")" { return PUNC; }
"{" { return PUNC; }
"}" { return PUNC; }
"->" { return PUNC; }
"&" { return PUNC; }
"*" { return PUNC; }
"+" { return PUNC; }
"-" { return PUNC; }
"/" { return PUNC; }
"%" { return PUNC; }
"!" { return PUNC; }
"?" { return PUNC; }
"<" { return PUNC; }
">" { return PUNC; }
"<=" { return PUNC; }
">=" { return PUNC; }
"==" { return PUNC; }
"!=" { return PUNC; }
"&&" { return PUNC; }
"||" { return PUNC; }
"=" { return PUNC; }
":" { return PUNC; }
";" { return PUNC; }
"," { return PUNC; }
{WS}        /* White-space Rule */;
%%
/* C functions */
