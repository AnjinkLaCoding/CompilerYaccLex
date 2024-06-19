FILE_lex=	B103040059.l
PROG_lex=	lex.yy.c
all:	$(PROG_lex)
	gcc $(PROG_lex) -lfl

$(PROG_lex):	$(FILE_lex)
	flex -i $(FILE_lex)

clean:
	rm a.out $(PROG_lex)
