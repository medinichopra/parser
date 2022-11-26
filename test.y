%{
 /* C Declarations and Definitions */

#include <string.h>
#include <stdio.h>
extern int yylex(); // Generated by Flex

void yyerror(const char *s);

%}

/*Bison Declarations*/

%token CHAR ELSE FOR IF INT
%token RET VOID ID 
%token INT_CONST CHAR_CONST 
%token STR_LIT PUNC 
%token MULTI_COMM SINGLE_COMM WS
%token EQ_OPT LE_OPT GE_OPT NE_OPT 
%token AND_OPT PTR_OPT OR_OPT

%start translation_unit

%%
/*Grammar Rules*/
/*Read from here!!!!*/
/*expressions:*/
/* The grammar is structured in a hierarchical way with precedences resolved. Associativity is handled
by left or right recursion as appropriate.*/

primary_expression:
	ID { printf("= %d\n", $1); } // Simple identifier 
	|INT_CONST { printf("= %d\n", $1); } // Integer or character constant
	|CHAR_CONST { printf("= %d\n", $1); }
	|STR_LIT { printf("= %d\n", $1); }
	|'(' expression ')' { $$ = $2; }
;

postfix_expression: 
	primary_expression
	|postfix_expression '[' expression ']'
	|postfix_expression '(' argument_expression_list_opt ')'
;
argument_expression_list_opt:
	%empty |
	argument_expression_list
;

argument_expression_list:
	assignment_expression
	|argument_expression_list ',' assignment_expression
;

unary_operator: 
	'&'|'*'|'-'|'!' 
;

unary_expression:
	postfix_expression
	|unary_operator unary_expression // Expr. with prefix ops. Right assoc. in C; non-assoc. here
;	// Only a single prefix op is allowed in an expression here

multiplicative_expression: // Left associative operators
	unary_expression
	|multiplicative_expression '*' unary_expression { $$ = $1 * $3; }
	|multiplicative_expression '/' unary_expression { if ($3 == 0)
	yyerror("divide by zero");
	else $$ = $1 / $3;
	}
	|multiplicative_expression '%' unary_expression
;

additive_expression: // Left associative operators
	multiplicative_expression
	|additive_expression '+' multiplicative_expression { $$ = $1 + $3; }
	|additive_expression '-' multiplicative_expression { $$ = $1 - $3; }
;
	
relational_expression: // Left associative operators
	additive_expression
	| relational_expression '<' additive_expression
	| relational_expression '>' additive_expression
	| relational_expression LE_OPT additive_expression
	| relational_expression GE_OPT additive_expression
;

equality_expression: // Left associative operators
	relational_expression
	|equality_expression EQ_OPT relational_expression
	|equality_expression NE_OPT relational_expression
;
	
logical_AND_expression: // Left associative operators
	equality_expression
	|logical_AND_expression AND_OPT equality_expression
;

logical_OR_expression: // Left associative operators
	logical_AND_expression
	|logical_OR_expression OR_OPT logical_AND_expression
;
	
conditional_expression: // Right associative operator
	logical_OR_expression
	|logical_OR_expression '?' expression ':' conditional_expression
;

assignment_expression: // Right associative operator
	conditional_expression
	|unary_expression '=' assignment_expression // unary-expression must have lvalue
;

expression:
	assignment_expression
;
	
/*Declarations*/
declaration: // Simple identifier, 1-D array or function declaration of built-in type
	type_specifier init_declarator ';' // Only one element in a declaration
;

init_declarator:
	declarator//(maybe not sure) Simple identifier, 1-D array or function declaration
	|declarator '=' initializer // Simple id with init. initializer for array / fn/ is semantically skipped
;

type_specifier: // Built-in types
	VOID
	|CHAR
	|INT
;

declarator:
	pointer_opt direct_declarator // Optional injection of pointer
;

direct_declarator:
	ID // Simple identifier
	|ID '[' INT_CONST ']' // 1-D array of a built-in type or ptr to it. Only +ve constant
	|ID '(' parameter_list_opt ')'  // Fn. header with params of built-in type or ptr to them
;

pointer:
	'*'
;

pointer_opt:
%empty |
pointer
;

parameter_list:
	parameter_declaration
	|parameter_list ',' parameter_declaration
;

parameter_list_opt:
	%empty|
	parameter_list
;

parameter_declaration:
	type_specifier pointer_opt identifier_opt // Only simple ids of a built-in type or ptr to it as params
;

identifier_opt:
	%empty|
	ID
;

initializer:
	assignment_expression
;

//3. Statements
statement:
	compound_statement // Multiple statements and / or nest block/s
	|expression_statement // Any expression or null statements
	|selection_statement // if or if-else
	|iteration_statement // for
	|jump_statement // return
;

compound_statement:
	'{' block_item_list_opt '}'
;

block_item_list_opt:
	%empty |
	block_item_list
;

block_item_list:
	block_item
	|block_item_list block_item
;

block_item: // Block scope - declarations followed by statements
	declaration
	|statement
;

expression_statement:
	expression_opt ';' // do we remove this semi colon?
;

selection_statement:
	IF '(' expression ')' statement
	|IF '(' expression ')' statement ELSE statement
;

expression_opt:
%empty |
expression
;

iteration_statement:
	FOR '(' expression_opt ';' expression_opt ';' expression_opt ')' statement
;

jump_statement:
	RET expression_opt ';'
;

/*4. Translation Unit*/
translation_unit: // Single source file containing main()
	function_definition
	|declaration
;

function_definition:
	type_specifier declarator compound_statement
;

declaration_list:
	declaration
	|declaration_list declaration
;

declaration_list_opt:
	%empty |
	declaration_list
;

%%
/*Additional C Code*/

void yyerror(const char *s) {
	printf("%s", s);
}

