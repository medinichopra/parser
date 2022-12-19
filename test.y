%{
 /* C Declarations and Definitions */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "test.h"
extern int yylex(); 

void yyerror(char *s);
void printrule(char *s);

/*Bison Declarations*/

quad *qArray[NSYMS];
int quadPtr = 0; 

struct list {
  int val;
  struct list *next;
};

struct list *make_list(int val, struct list *next) {
  struct list *new_list = (struct list *)malloc(sizeof(struct list));
  new_list->val = val;
  new_list->next = next;
  return new_list;
}

void backpatch(struct list *list, int target) {
  for (struct list *p = list; p != NULL; p = p->next) {
    printf("%d: goto %d\n", p->val, target);
  }
/*

static int next_label = 0;

int merge(struct list *p1, struct list *p2) {
  int label = next_label++;
  backpatch(p1, label);
  backpatch(p2, label);
  return label;
}
*/
%}

%union { 
	int intval;
	symboltable *symp;
}

%token <intval> NUMBER
%token <symp> NAME CHAR ELSE FOR IF INT RET VOID ID CHAR_CONST STR_LIT 
%token PUNC 
%token MULTI_COMM SINGLE_COMM WS
%token EQ_OPT LE_OPT GE_OPT NE_OPT 
%token AND_OPT PTR_OPT OR_OPT
%type <symp> primary_expression multiplicative_expression additive_expression unary_expression relational_expression postfix_expression equality_expression assignment_expression selection_statement


%left '='
%left '|'
%left '^'
%left '&'
%left '+' '-'
%left '*' '/' '%'
%nonassoc UMINUS

%start translation_unit

%%

list_of_statements: statement
{ printrule("L -> S"); }
;
list_of_statements: list_of_statements statement
{ printrule("L -> L S"); }
;
statement: ID '=' additive_expression ';' 
{ 
	qArray[quadPtr++] = new_quad_unary(COPY, $1->name, $3->name);
	printrule("S -> id = E"); 
}
;

primary_expression:
	ID { $$ = $1; printrule("E -> id"); }
	|NUMBER {
	$$ = gentemp();
	char num_s[10];
	sprintf(num_s, "%d", $1);
	qArray[quadPtr++] = new_quad_unary(COPY, $$->name, num_s);
	printrule("E -> num");
	}
	
	|CHAR_CONST { $$ = $1; printrule("E -> Character"); }
	|STR_LIT { $$ = $1; printrule("E -> String"); }
	|'(' primary_expression ')' { $$ = $2; printrule("E -> (E)"); }
;

postfix_expression: 
	primary_expression { $$ = $1; printrule("postfix -> primary"); }
	|postfix_expression '[' expression ']' { $$ = $2; printrule("E -> [E]"); }
	|postfix_expression '(' argument_expression_list_opt ')' { $$ = $2; printrule("E -> (E)"); }
;
/*
argument_expression_list_opt: %empty |
	argument_expression_list { $$ = $1; printrule("argument_express_list"); }
;

argument_expression_list:
	assignment_expression { $$ = $1; printrule("unary -> postfix"); }
	|argument_expression_list ',' assignment_expression
;
*/

unary_operator: 
	'&'|'*'|'-'|'!' 
;

unary_expression:
	postfix_expression { $$ = $1; printrule("unary -> postfix"); } 
	|unary_operator unary_expression 
	;

multiplicative_expression:
	unary_expression
	|multiplicative_expression '*' unary_expression 
{
	$$ = gentemp();
	qArray[quadPtr++] = new_quad_binary(MULT, $$->name, $1->name, $3->name);
	printrule("E -> E * E");
}
	|multiplicative_expression '/' unary_expression
{
	$$ = gentemp();
	qArray[quadPtr++] = new_quad_binary(DIV, $$->name, $1->name, $3->name);
	printrule("E -> E / E");
}
	|multiplicative_expression '%' unary_expression
;

additive_expression:
	multiplicative_expression { $$ = $1; printrule("additive -> multiplicative"); }
	|additive_expression '+' multiplicative_expression {
	$$ = gentemp();
	qArray[quadPtr++] = new_quad_binary(PLUS, $$->name, $1->name, $3->name);
	printrule("E -> E + E");
}
	|additive_expression '-' multiplicative_expression {
	$$ = gentemp();
	qArray[quadPtr++] = new_quad_binary(MINUS, $$->name, $1->name, $3->name);
	printrule("E -> E - E");
}
;

relational_expression: 
	additive_expression
	| relational_expression '<' additive_expression
	{
		$$ = gentemp();
		qArray[quadPtr++] = new_quad_binary(LE, $$->name, $1->name, $3->name);
		printrule("E -> E < E");
	}
	| relational_expression '>' additive_expression
	{	
		$$ = gentemp();
		qArray[quadPtr++] = new_quad_binary(GE, $$->name, $1->name, $3->name);
		printrule("E -> E > E");
	}
	| relational_expression LE_OPT additive_expression
	{
		$$ = gentemp();
		qArray[quadPtr++] = new_quad_binary(LTE, $$->name, $1->name, $3->name);
		printrule("E -> E <= E");
	}
	| relational_expression GE_OPT additive_expression
	{
		$$ = gentemp();
		qArray[quadPtr++] = new_quad_binary(GTE, $$->name, $1->name, $3->name);
		printrule("E -> E >= E");
	}
;

equality_expression: 
	relational_expression
	|equality_expression EQ_OPT relational_expression
	{
		$$ = gentemp();
		qArray[quadPtr++] = new_quad_binary(MINUS, $$->name, $1->name, $3->name);
		printrule("E -> E == E");
	}
	|equality_expression NE_OPT relational_expression
	{
		$$ = gentemp();
		qArray[quadPtr++] = new_quad_binary(MINUS, $$->name, $1->name, $3->name);
		printrule("E -> E != E");
	}
;
	
logical_AND_expression: 
	equality_expression
	|logical_AND_expression AND_OPT equality_expression
;


logical_OR_expression: 
	logical_AND_expression 
	|logical_OR_expression OR_OPT logical_AND_expression 
;
	
conditional_expression: 
	logical_OR_expression
	|logical_OR_expression '?' expression ':' conditional_expression
;

assignment_expression: 
	conditional_expression
	|unary_expression '=' assignment_expression 
	{
		$$ = gentemp();
		qArray[quadPtr++] = new_quad_binary(ASSIGN, $$->name, $1->name, $3->name);
		printrule("E -> E = E");
	}
;

expression:
	assignment_expression
;
	
declaration: 
	type_specifier init_declarator ';' 
;

init_declarator:
	declarator
	|declarator '=' initializer 
;

type_specifier:
	VOID
	|CHAR
	|INT
;

declarator:
	pointer_opt direct_declarator 
;

direct_declarator:
	ID 
	|ID '[' NUMBER ']' 
	|ID '(' parameter_list_opt ')'  

pointer:
	'*'
;

pointer_opt: %empty |
pointer
;

parameter_list:
	parameter_declaration
	|parameter_list ',' parameter_declaration
;

parameter_list_opt:
	%empty |
	parameter_list
;

parameter_declaration:
	type_specifier pointer_opt identifier_opt 

identifier_opt:
	%empty |
	ID
;

initializer:
	assignment_expression
;


statement:
	compound_statement 
	|expression_statement 
	|selection_statement 
	|iteration_statement 
	|jump_statement 
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

block_item: 
	declaration
	|statement
;

expression_statement:
	expression_opt ';' 
;

selection_statement:
	IF '(' expression ')' statement 
	|IF '(' expression ')' statement ELSE statement {
    int label1 = next_label++;
    int label2 = next_label++;
    backpatch($2.true_list, label1);
    backpatch($2.false_list, label2);
    printf("%d: if %d goto %d\n", label1, $4.place, label1 + 1);
    $$.next_list = make_list(label2, $2.next_list);
  }
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

translation_unit: 
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

void yyerror(char *s) {
	printf("%s\n", s);
}
void printrule(char *s) {
	FILE *fp = fopen("Trace.txt", "a");
	if (fp) {
		fprintf(fp, "%s\n", s);
	}
	fclose(fp);
}
int main() {
	yyparse();

	for (int i = 0; i < quadPtr; ++i)
		print_quad(qArray[i]);

	return 0;
}
/*Additional C Code*/


