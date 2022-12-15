.SUFFIXES: .yy.c .tab.c .tab.h

Parser:
	flex Lexer.l
	bison -dtv Parser.y
	gcc -c lex.yy.c -o lex.yy.o
	gcc -c Parser.tab.c -o Parser.tab.o
	gcc lex.yy.o Parser.tab.o Parser.c -ll
	