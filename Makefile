Parser:
	flex test.l
	bison -dtv test.y
	gcc test.tab.c lex.yy.c -ll -lm