%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define YYERROR_VERBOSE

int yylex();

extern int charCount,lineCount;
extern char TheType[100];
int ErrorFlag = 0;
int IFflag=0;
char IDdef[50][100];
char IDType[50][100];
int temp = 0, temp1 = 0;

void yyerror(const char *msg);
void Reset();

void CheckID(char* c){
	int len = strlen(c);
	if(strcmp(c,"INTEGER")==0 || strcmp(c,"REALTYPE")==0 || strcmp(c,"STRING")==0 || strcmp(c,"ARRAY")==0){
		for(int i=temp1;i<temp;i++){
			for(int j=0;j<strlen(c);j++){
            			IDType[i][j]=c[j];
        		}
        		IDType[i][len]='\0';
		}
		temp1 = temp;
	}else{
		for(int i=0;i<100;i++)
		{
			if(strcmp(c,IDdef[i])==0)
				return;
		}
		for(int i=0;i<strlen(c);i++){
            		IDdef[temp][i]=c[i];
    		}
    		IDdef[temp][len]='\0';
		temp++;
	}
}
%}

%union
{
	char*  Value;
};

%token<Value>	SEMICOLON DECLARE LESSEQ GREATEREQ EQUALEQ NOTEQ COLON LEFTPARENT RIGHTPARENT GREATERT LESST LG EQUAL LEFTSQP RIGHTSQP ADD SUB MULTI SLASH DOT COMMA 
%token<Value>	AND BEG BREAK CASE CONTINUE DO DIV ELSE END FOR IF MOD NOT OF OR PROGRAM THEN TO VAR ARRAY INTEGER WRITE WRITELN READ REALTYPE 
%token<Value>	INVALID ID REALNUM INT STRING STRINGS	
%type<Value>	prog prog_name dec_list dec type standtype arraytype id_list stmt_list stmt assign ifstmt exp relop simpexp term factor read write for index_exp varid body writeln error

%%

prog			:	PROGRAM prog_name SEMICOLON VAR dec_list SEMICOLON BEG stmt_list SEMICOLON END DOT
				| PROGRAM prog_name SEMICOLON VAR dec_list SEMICOLON BEG stmt_list SEMICOLON END{yyerror("\".\" expected but \"EOL\" found");}
				;

prog_name		: 	ID
				;

dec_list		: 	dec 
				| dec_list SEMICOLON dec
				;

dec			:	id_list COLON type
				| id_list DECLARE{yyerror("\":\" expected but \":=\" found");} type
				;

type			:	standtype
				| arraytype
				;

standtype		: 	INTEGER{CheckID("INTEGER");}
				| REALTYPE{CheckID("REALTYPE");}
				| STRING{CheckID("STRING");}
				;

arraytype		:	ARRAY LEFTSQP INT DOT DOT INT RIGHTSQP OF standtype{CheckID("ARRAY");}
				;

id_list			:	ID{CheckID($1);}
				| id_list COMMA ID{CheckID($3);}
				| error
				;

list			:	factor
				| list COMMA factor
				;

stmt_list		:	stmt
				| stmt_list SEMICOLON stmt
				;

stmt			:	assign
				| read
				| write
				| for
				| ifstmt
				| writeln
				;

assign			:	varid DECLARE simpexp
				| varid EQUAL{yyerror("\":=\" expected but \"=\" found");} simpexp
				;

ifstmt			: 	IF LEFTPARENT exp RIGHTPARENT THEN body
				| LEFTPARENT exp RIGHTPARENT{yyerror("Syntax error, \";\" expected but \"THEN\" found");} THEN body
				| IF LEFTPARENT exp RIGHTPARENT{yyerror("Syntax error, \"THEN\" expected before body section");} body
				| IF{yyerror("Syntax error, \"(\" expected but expression found");} exp RIGHTPARENT THEN body
				| IF LEFTPARENT exp{yyerror("Syntax error, \")\" expected but \"THEN\" found");} THEN body
				;

exp			:	simpexp
				| exp relop simpexp
				;

relop			:	GREATERT | LESST | GREATEREQ | LESSEQ | LG | EQUAL
				;

simpexp			: 	term
				| simpexp ADD term
				| simpexp SUB term
				;

term			:	factor
				| factor MULTI factor
				| factor DIV factor
				| factor MOD factor
				;

factor			:	varid
				| INT
				| REALNUM
				| STRINGS
				| LEFTPARENT simpexp RIGHTPARENT
				;
 
read			:	READ LEFTPARENT id_list RIGHTPARENT
				;
		
write			:	WRITE LEFTPARENT list RIGHTPARENT
				| WRITE LEFTPARENT list{yyerror("Syntax error, \")\" expected but \";\" found");}
				| WRITE{yyerror("Syntax error, \";\" expected but other found");} list RIGHTPARENT
				;

writeln			:	WRITELN LEFTPARENT list RIGHTPARENT 
				| WRITELN
				;

for			:	FOR index_exp DO body
				;

index_exp		:	varid DECLARE simpexp TO exp
				;

varid			:	ID
				| ID LEFTSQP simpexp RIGHTSQP
				| ID{yyerror("Syntax error, \"[\" expected but not found");} simpexp RIGHTSQP
				| ID LEFTSQP simpexp{yyerror("Syntax error, \"]\" expected but not found");}
				;

body			:	stmt
				| BEG stmt_list SEMICOLON END
				| BEG stmt_list END{yyerror("Syntax error, \";\" expected but \"END\" found");}
				;

%%
int main()
{
	Reset();
	yyparse();
	printf("\n");
	return 0;
}

void yyerror(const char *msg)
{
	charCount-=strlen(yylval.Value);
	printf("\rLine %2d, at char: %2d, %s\n", lineCount, charCount, msg);
	ErrorFlag = 1;
}
void Reset()
{
	for(int i = 0; i < 50; i++)
	{
		for(int j = 0; j < 100; j++)
		{
			IDType[i][j]='\0';
			IDdef[i][j]='\0';
		}
		TheType[i]='\0';
	}
}