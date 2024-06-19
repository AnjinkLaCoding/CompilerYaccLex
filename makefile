all:	clean y.tab.c lex.yy.c
	gcc lex.yy.c y.tab.c -lfl -o pars

y.tab.c:
	bison -y -d B103040059.y

lex.yy.c:
	flex -i B103040059.l

clean:
	rm -f pars lex.yy.c y.tab.c y.tab.h