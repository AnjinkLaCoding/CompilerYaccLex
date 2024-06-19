%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char IDdef[50][100];
extern char IDType[50][100];
extern int ErrorFlag;
int charCount = 1, lineCount = 1;
int deter_flag = 0, nLine_flag = 0;
char TheType[100];
int begin_flag = 0;
int WSFlag=0;

void CommentCheck();
void NewLineCheck();

%}

NEWLINE 	[\r]?\n
SPACE 		[ \t]
SEMICOLON 	;
DECLARE 	:=
LESSEQ 		<=
GREATEREQ 	>=
EQUALEQ 	==
NOTEQ 		!=
COLON 		[:]
LEFTPARENT 	[(]
RIGHTPARENT 	[)]
GREATERT 	>
LESST 		<
EQUAL 		=
LG 		<>
LEFTSQP 	\[
RIGHTSQP 	\]
ADD 		\+
SUB 		\-
MULTI 		\*
SLASH 		\/
DOT 		\.
COMMA 		\,
AND		and
BEG		begin
BREAK		break
CASE		case
CONTINUE	continue
DO		do
DIV		div
ELSE		else
END		end
FOR		for
IF		if
MOD		mod
NOT		not
OF		of
OR		or
PROGRAM		program
THEN		then
TO		to
VAR		var
ARRAY		array
INTEGER		integer
WRITE		write
WRITELN		writeln
READ		read
STRING		string
REALTYPE	realtype
COMMENT 	\(\*.?([^\)\*][^\)])*\*\)
STRINGS 	\'.{1,30}\'|\'\'
REALNUM 	([+-]?([0-9]+\.[0-9]+))([eE][-+]?[0-9]*)?
INVREAL 	[-+]?([0-9]+\.|\.[0-9]+)([eE][-+]?[0-9]*)?
ID 		[a-zA-Z_][a-zA-Z0-9_]{0,14}
ARITH 		[-+]?([1-9][0-9]*|0)[+*/-]([1-9][0-9]*|0)
INT 		[-+]?([1-9][0-9]*|0)
else .

%%
{NEWLINE}	{NewLineCheck();}
{SPACE}		{charCount++; printf("%s", yytext);}
{SEMICOLON}	{deter_flag = 0; printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return SEMICOLON;}
{DECLARE}	{deter_flag = 1; printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return DECLARE;}
{LESSEQ}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return LESSEQ;}
{GREATEREQ}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return GREATEREQ;}
{EQUALEQ}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return EQUALEQ;}
{NOTEQ}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return NOTEQ;}
{COLON}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return COLON;}
{LEFTPARENT}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return LEFTPARENT;}
{RIGHTPARENT}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return RIGHTPARENT;}
{GREATERT}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return GREATERT;}
{LESST}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return LESST;}
{EQUAL}		{deter_flag = 1; printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return EQUAL;}
{LG}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return LG;}
{LEFTSQP}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return LEFTSQP;}
{RIGHTSQP}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return RIGHTSQP;}
{ADD}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return ADD;}
{SUB}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return SUB;}
{MULTI}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return MULTI;}
{SLASH}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return SLASH;}
{DOT}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return DOT;}
{COMMA}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return COMMA;}
{AND}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return AND;}
{BEG}		{begin_flag = 1; printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return BEG;}
{BREAK}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return BREAK;}
{CASE}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return CASE;}
{CONTINUE}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return CONTINUE;}
{DO}		{deter_flag = 0; printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return DO;}
{DIV}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return DIV;}
{ELSE}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return ELSE;}
{END}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return END;}
{FOR}		{deter_flag = 1; printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return FOR;}
{IF}		{deter_flag = 1; printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return IF;}
{MOD}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return MOD;}
{NOT}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return NOT;}
{OF}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return OF;}
{OR}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return OR;}
{PROGRAM}	{printf("Line %2d: ", lineCount);printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return PROGRAM;}
{THEN}		{deter_flag =0; printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return THEN;}
{TO}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return TO;}
{VAR}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return VAR;}
{ARRAY}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return ARRAY;}
{INTEGER}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return INTEGER;}
{WRITE}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return WRITE;}
{WRITELN}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return WRITELN;}
{READ}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return READ;}
{STRING}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return STRING;}
{REALTYPE}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return REALTYPE;}
{COMMENT}	{CommentCheck();}
{ARITH} 	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return INT;}
{INT}		{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return INT;}
{REALNUM}	{printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext; return REALNUM;}
{INVREAL}	{printf("Line: %2d, at char: %2d,\"%s\" is an invalid \"real number\".\n",lineCount,charCount,yytext);charCount += yyleng;return INVALID;}
{STRINGS}	{
			int Doublecat=0;
			for(int i=0;i<yyleng;i++){
				if(yytext[i]=='\'' && yytext[i+1]=='\''){
					for(int j=i+1;j<yyleng-1;j++){
						yytext[j]=yytext[j+1];
					}
					Doublecat++;
				}
			}
			if(Doublecat!=0){
				for(int i=0;i<Doublecat;i++){
					yyleng--;
					yytext[yyleng]='\0';
				}
			}
			printf("%s", yytext);
			charCount+=yyleng;
			return STRINGS;
}

{ID}		{
				int j=0;
				printf("%s",yytext); charCount+=yyleng; yylval.Value=yytext;
				if(begin_flag)
				{
					for(int k=0; k<50; k++)
					{
						if(IDType[k][0] == '\0')
						{
							for(int l = 0; l < 100; l++)
							{
								IDdef[k][l] = '\0';
							}
							
						}
					}
					for(int i = 0; i<100; i++)
					{
						if(strcmp(yytext,IDdef[i])==0)
						{
							j=i;
							break;
						}
						if(i==99)
						{
							printf("\rLine %2d, at char: %2d, \"%s\" is not defined.\n", lineCount, charCount-1, yytext);
							ErrorFlag = 1;
						}
					}
					if(deter_flag==1)
					{
						if(strcmp(TheType,IDType[j])!=0)
						{
							printf("\rLine %2d, at char: %2d, %s is a %s, different type from the ID.\n", lineCount, charCount, IDdef[j], IDType[j]);
							ErrorFlag = 1;
						}
					}else{
						for(int i=0;i<100;i++){
							if(strcmp(yytext,IDdef[i])==0){
								j=i;
								break;
							}
						}
						strcpy(TheType,IDType[j]);
					}
				}
				return(ID);
}
{else}		{
	
	printf("error detected : \"%s\".\n",yytext);
	charCount += yyleng;
}
%%

int yywrap(){
    return 1;
}

void CommentCheck(){
	int FlagNl = 0;
	int FlagEnd = 0;
	for(int i=0; i<yyleng-1;i++){
		if(yytext[i]=='(' && yytext[i+1]=='*'){
			FlagEnd++;
		}else if(yytext[i]=='*' && yytext[i+1]==')'){
			FlagEnd--;
		}
		if(yytext[i]=='\n'){
			FlagNl++;
		}
	}
	
	if(FlagEnd!=0){
		printf("\r\t\t\t\t");
		printf("\rLine %2d: at char: %2d, \"%s\" is a invalid \"comment\".\n", lineCount, charCount, yytext);
	}else{
		nLine_flag = 1;
	}
	charCount+=yyleng;
	lineCount+=FlagNl;
}

void NewLineCheck(){
	deter_flag = 0;
	lineCount++; 
	charCount=1;
	if(ErrorFlag==1){
		ErrorFlag = 0;
		printf("\rLine %2d: ", lineCount);
	}else if(nLine_flag==0){
		printf("\nLine %2d: ", lineCount);
	}else{
		printf("\rLine %2d: ", lineCount);
		nLine_flag=0;
	}
}