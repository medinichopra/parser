%{
	/*definition*/
	#include <string.h>
	#include <stdio.h>
	extern int yylex();
	void yyerror(char* s);
%}
	/*rules*/
%union {
	int intval;
	char* chval;
	char* str;
}

%token <str> IDENTIFIER
%token <chval> CONSTANT
%token <intval> I_CONSTANT
%token <str> STRLIT
%token INT CHAR IF ELSE VOID RETURN FOR
%token AND_OP OR_OP LE_OP GE_OP EQ_OP NE_OP PTR_OP

%nonassoc '-'
%left "+""_"
%%
statement: expression ;

//Expressions
primary_expression: IDENTIFIER {printf("%s\n", $1);}
| CONSTANT
| STRLIT
| I_CONSTANT
| '(' expression ')' {printf("primary_expression <_ ( expression)");}
;

postfix_expression: primary_expression 
| postfix_expression '[' expression ']' 
| postfix_expression '(' argument_expression_list ')' 
| postfix_expression PTR_OP IDENTIFIER
;

argument_expression_list: assignment_expression 
|argument_expression_list ',' assignment_expression
;

unary_expression: postfix_expression
| unary_operator unary_expression
;

unary_operator: '&' | '*' | '+' | '-' | '!'
;

multiplicative_expression: unary_expression
| multiplicative_expression '*' unary_expression
| multiplicative_expression '/' unary_expression
| multiplicative_expression '%' unary_expression
;

additive_expression: multiplicative_expression 
| additive_expression '+' multiplicative_expression 
| additive_expression '-' multiplicative_expression
;

relational_expression: additive_expression
| relational_expression '<' additive_expression 
| relational_expression '>' additive_expression 
| relational_expression LE_OP additive_expression 
| relational_expression GE_OP additive_expression 
;

equality_expression: relational_expression 
| equality_expression EQ_OP relational_expression 
| equality_expression NE_OP relational_expression
;

logical_AND_expression: equality_expression 
| logical_AND_expression AND_OP equality_expression
;

logical_OR_expression: logical_AND_expression 
| logical_OR_expression OR_OP logical_AND_expression
;

conditional_expression: logical_OR_expression 
| logical_OR_expression '?' expression ':' conditional_expression
;

assignment_expression: conditional_expression 
| unary_expression '=' assignment_expression
;

expression: assignment_expression
;
 

// Declarations

declaration: type_specifier init_declarator ; 

init_declarator: declarator 
| declarator '=' initializer
;

type_specifier: VOID
| CHAR
| INT
;

declarator: pointer_opt direct_declarator
| direct_declarator:
| IDENTIFIER 
| IDENTIFIER '[' I_CONSTANT ']' 
| IDENTIFIER '(' parameter_list_opt ')' 
;

pointer: '*' ;

pointer_opt: 
| pointer
;

parameter_list: parameter_declaration
| parameter_list ',' parameter_declaration
;

parameter_list_opt: 
| parameter_list
;

identifier_opt:
| IDENTIFIER
;

parameter_declaration: type_specifier pointer_opt identifier_opt;
initializer: assignment_expression;

// STATEMENTS
statement: compound_statement // Multiple statements and / or nest block/s
| expression_statement // Any expression or null statements
| selection_statement // if or if_else
| iteration_statement // for
| jump_statement
;

compound_statement:'{'block_item_list_opt'}';

block_item_list_opt: 
| block_item_list
;

block_item_list: block_item
| block_item_list block_item
;

block_item: declaration
| statement
;

expression_statement: expression_opt ';' ;

expression_opt: 
| expression
;

selection_statement:
IF '(' expression ')' statement
| IF '(' expression ')' statement ELSE statement
;

iteration_statement:
FOR '(' expression_opt ';' expression_opt ';' expression_opt ')' statement ;

jump_statement:
RETURN expression_opt ;

translation_unit: 
function_definition
| declaration
;

function_definition: type_specifier declarator '(' declaration_list_opt ')' compound_statement
;

declaration_list_opt:
| declaration_list
;

declaration_list: declaration
| declaration_list declaration
;


%%
//void yyerror(char* s) {
	//std::cout << s << std::endl;}
int main(){
	yyparse();
	return 0;
}

void yyerror(char* s) {
	printf("ERROR!: %s\n",s);
}
