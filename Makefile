.SUFFIXES: .yy.c .tab.c .tab.h

Parser:
	flex test.l
	bison -dtv test.y
	gcc -c lex.yy.c -o lex.yy.o
	gcc -c test.tab.c -o test.tab.o
	gcc lex.yy.o test.tab.o test.c -lfl
	
