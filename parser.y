%{ /* C Declarations and Definitions */
#include <string.h>
#include <iostream>
extern int yylex(); // Generated by Flex
void yyerror(char *s);
%}

%token NUMBER
%token KEYWORD
%token CONST
%token PUNC
%token IDENTIFIER

%nonassoc '-'

%%
statement: expression
;

// EXPRESSIONS
primary_expression: IDENTIFIER 
| CONST 
|'(' expression ')'
;

postfix_expression: primary_expression 
| postfix_expression '[' expression ']' 
| postfix_expression '(' argument_expression_list ')' '
| postfix_expression '(' ')' 
| postfix_expression PTR_OP IDENTIFIER
;


%%
void yyerror(char *s) { // Called on error
std::cout << s << std::endl;
}
int main() {
	yyparse(); // Generated by Bison
	return 0;
}
