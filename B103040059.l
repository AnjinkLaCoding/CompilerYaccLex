%{
#include<stdio.h>
unsigned charCount = 1,lineCount = 1;
void error_ident();
%}

reserved	absolute|and|begin|break|case|const|continue|do|else|end|for|function|if|mod|nil|not|object|of|or|program|then|to|var|while|array|integer|double|write|writeln|string|float|read
symbol	=[=]?|([<>][=]?)|\.|;|\[|\]|\(|\)|(:[=]?)|\+|\-|\*|\/|,
Arith	[0-9]+\+[0-9]+|[0-9]+\-[0-9]+|[0-9]+\*[0-9]+|[0-9]+\/[0-9]+

Interger	[-+]?([1-9][0-9]*|0)
InvalidInterger	[-+]?0[0-9]+

realnumber	([+-]?([0-9]+\.[0-9]+))([eE][-+]?[0-9]*)?
InvalidReal	[+-]?([0-9]+\.|\.[0-9]+)([eE][-+]?[0-9]*)?

String	\'[^\n]{1,30}\'|\'\'
InvalidString	\'[a-zA-Z0-9_\.]*|[a-zA-Z0-9_\.]*\'|[\'][^\n]{31,}[\']|\'[^\n]{1,30}\'[a-zA-Z0-9]+

comment	 \(\*([^*]|(\*+[^*\/]))*\*+\)|\*{5}[^\n]
Invalidcomment	\(\*(.*?)\*\)(.*?)\*\)|[^\(\*]*\*\)

id	[a-zA-Z_][a-zA-Z0-9_]{0,14}
idError	[0-9\^\#][a-zA-Z0-9_]+|[a-zA-Z_][a-zA-Z0-9_]{15,}

space [ \t]?
eol \n|\r|\r\n
%%
{reserved} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"reserved word\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
}
{symbol} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"symbol\".\n", lineCount, charCount, yytext);
	charCount+=yyleng;
}
{Arith} {
	printf("Line: %d, 1st char: %d, \"", lineCount, charCount);
	int i=0;
	while(yytext[i]>='0' && yytext[i]<='9'){
		printf("%c",yytext[i]);
		i++;
	}
	charCount+=i;
	printf("\" is an \"interger\".\n");
	printf("Line: %d, 1st char: %d, \"%c\" is a \"symbol\".\n", lineCount, charCount, yytext[i]);
	charCount++;
	i++;
	printf("Line: %d, 1st char: %d, \"", lineCount, charCount);
	while(yytext[i]>='0' && yytext[i]<='9'){
		printf("%c",yytext[i]);
		i++;
		charCount++;
	}
	printf("\" is an \"interger\".\n");
}
{Interger} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"interger\".\n", lineCount, charCount, yytext);
	charCount+=yyleng;
}
{InvalidInterger} {
	printf("Line: %d, 1st char: %d, \"%s\" is not an \"interger\".\n", lineCount, charCount, yytext);
	charCount+=yyleng;
}
{realnumber} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"real number\".\n", lineCount, charCount, yytext);
	charCount+=yyleng;
}
{InvalidReal} {
	printf("Line: %d, 1st char: %d, \"%s\" is not a \"real number\".\n", lineCount, charCount, yytext);
	charCount+=yyleng;
}
{String} {
	int pos=0; /* for index */
	int count=0; /* for count ' */
	int i;
	int flag=0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\''){
			count++;
		}
	}
	if(count%2==0){
		if(count==2){
			if(yytext[0]=='\'' && yytext[1]=='\''){
				printf("Line: %d, 1st char: %d, \"%s\" is a \"whitespace\".\n", lineCount, charCount, yytext);
				charCount+=yyleng;
			}else{
				printf("Line: %d, 1st char: %d, \"%s\" is a \"string\".\n", lineCount, charCount, yytext);
				charCount+=yyleng;
			}
		}else{
			printf("Line: %d, 1st char: %d, \"",lineCount, charCount);
			for(i=0;i<yyleng;i++){
				if(yytext[i]=='\'' && yytext[i+1]=='\'' && i!=0 && i+1!=yyleng){
					printf("%c", yytext[i]);
					i+=1;
					flag=1;
				}else{
					printf("%c", yytext[i]);
				}
			}
			printf("\" is a \"string\".\n");
			charCount+=yyleng;
		}
	}else{
		printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"string\".\n", lineCount, charCount, yytext);
		charCount+=yyleng;
	}
}
{InvalidString} {
	printf("Line: %d, 1st char: %d, \"%s\" is a invalid \"string\".\n", lineCount, charCount, yytext);
	charCount+=yyleng;
}
{comment} {
	printf("Line: %d, 1st char: %d, \"%s\" is a valid \"comment\".\n", lineCount, charCount, yytext);
	int i;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){
			lineCount++;
		}
	}
}
{Invalidcomment} {
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"comment\".\n", lineCount, charCount, yytext);
	int i;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){
			lineCount++;
		}
	}
}
{id} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"ID\".\n", lineCount, charCount, yytext);
	charCount+=yyleng;
}
{idError} {
	error_ident();
	charCount+=yyleng;
}
{space} {
	charCount++;
}
{eol} {
	lineCount++; 
	charCount = 1;
}
%%

int main()
{
	yylex(); 	
	return 0;
}

void error_ident(){
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"ID\".\n", lineCount, charCount, yytext);
}
