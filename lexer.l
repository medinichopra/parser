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
{CHAR}       { printf("<keyword, char>\n"); /* Keyword Rule */ }
{IF}       { printf("<keyword, if>\n"); /* Keyword Rule */ }
{ELSE}       { printf("<keyword, else>\n"); /* Keyword Rule */ }
{VOID}       { printf("<keyword, void>\n"); /* Keyword Rule */ }
{RETURN}       { printf("<keyword, return>\n"); /* Keyword Rule */ }
{FOR}       { printf("<keyword, for>\n"); /* Keyword Rule */ }
{INTCONST} { yylval.num = atoi(yytext); return NUMBER; }
{CCONST} { printf("<constant, %s>\n", yytext); /* Keyword Rule */ }
{SCONST} { printf("<string-literal, %s>\n", yytext); /* Keyword Rule */ }
{ID}        { return ID; /* Identifier Rule & yytext points to lexeme */}
{SL} /* Single line Comment Rule */ ;
{ML} /* Multi line Comment Rule */ ;
"[" { printf("<punctuator, [>\n"); /* Punctuator Rule */ }
"]" { printf("<punctuator, ]>\n"); /* Punctuator Rule */ }
"(" { printf("<punctuator, (>\n"); /* Punctuator Rule */ }
")" { printf("<punctuator, )>\n"); /* Punctuator Rule */ }
"{" { printf("<punctuator, {>\n"); /* Punctuator Rule */ }
"}" { printf("<punctuator, }>\n"); /* Punctuator Rule */ }
"->" { printf("<punctuator, ->>\n"); /* Punctuator Rule */ }
"&" { printf("<punctuator, &>\n"); /* Punctuator Rule */ }
"*" { printf("<punctuator, *>\n"); /* Punctuator Rule */ }
"+" { printf("<punctuator, +>\n"); /* Punctuator Rule */ }
"-" { printf("<punctuator, ->\n"); /* Punctuator Rule */ }
"/" { printf("<punctuator, />\n"); /* Punctuator Rule */ }
"%" { printf("<punctuator, %%>\n"); /* Punctuator Rule */ }
"!" { printf("<punctuator, !>\n"); /* Punctuator Rule */ }
"?" { printf("<punctuator, ?>\n"); /* Punctuator Rule */ }
"<" { printf("<punctuator, <>\n"); /* Punctuator Rule */ }
">" { printf("<punctuator, >>\n"); /* Punctuator Rule */ }
"<=" { printf("<punctuator, <=>\n"); /* Punctuator Rule */ }
">=" { printf("<punctuator, >=>\n"); /* Punctuator Rule */ }
"==" { printf("<punctuator, ==>\n"); /* Punctuator Rule */ }
"!=" { printf("<punctuator, !=>\n"); /* Punctuator Rule */ }
"&&" { printf("<punctuator, &&>\n"); /* Punctuator Rule */ }
"||" { printf("<punctuator, ||>\n"); /* Punctuator Rule */ }
"=" { printf("<punctuator, =>\n"); /* Punctuator Rule */ }
":" { printf("<punctuator, :>\n"); /* Punctuator Rule */ }
";" { printf("<punctuator, ;>\n"); /* Punctuator Rule */ }
"," { printf("<punctuator, ,>\n"); /* Punctuator Rule */ }
{WS}        /* White-space Rule */;
%%
/* C functions */
