package miniphp;
import static miniphp.Token.*;
%%
%class Lexer
%type Token
L = [a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
ACENT=["á"|"é"|"í"|"ó"|"ú"|"ñ"]
D = [0-9]
a = [aA]
b = [bB]
c = [cC]
d = [dD]
e = [eE]
f = [fF]
g = [gG]
h = [hH]
i = [iI]
j = [jJ]
k = [kK]
l = [lL]
m = [mM]
n = [nN]
o = [oO]
p = [pP]
q = [qQ]
r = [rR]
s = [sS]
t = [tT]
u = [uU]
v = [vV]
w = [wW]
x = [xX]
y = [yY]
z = [zZ]
string_type = ('([^(')(\n)]|\\')*')|(\"([^(\")(\n)]|\\\")*\")

%{
public String lexeme;
%}
%%
"=" {return ASSIGN;}
"+" {return SUMA;}
"*" {return MULT;}
"-" {return RESTA;}
"/" {return DIV;}
[ \t\r]+        {lexeme=yytext(); return BLANK;}
[\n]+           {lexeme=yytext(); return NEWLINE;}
({L}|{ACENT})({L}|{ACENT}|{D})* {lexeme=yytext(); return ID;}
 ("(-"{D}+")")|{D}+ {lexeme=yytext(); return INT;}
"<?php" {lexeme=yytext(); return ABRE_PHP;}
"?>"    {lexeme=yytext(); return CIERRA_PHP;} 
{string_type}   {lexeme=yytext(); return STRING;}
. {return ERROR;}
