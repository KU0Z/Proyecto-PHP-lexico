package miniphp;
import static miniphp.Token.*;
%%
%class Lexer
%type Token
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
texto_basico= [a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
palabras_reservadas=(("_")("_"){h}{a}{l}{t}("_"){c}{o}{m}{p}{i}{l}{e}{r}|{a}{b}{s}{t}{r}{a}{c}{t}|{a}{r}{r}{a}{y}|{a}{s}|{c}{a}{l}{l}{a}{b}{l}{e}|{c}{a}{t}{c}{h}|{c}{l}{a}{s}{s}|{c}{l}{o}{n}{e}|{c}{o}{n}{s}{t}|{d}{e}{c}{l}{a}{r}{e}|{d}{e}{f}{a}{u}{l}{t}|{d}{i}{e}|{e}{c}{h}{o}|{e}{m}{p}{t}{y}|{e}{n}{d}{d}{e}{c}{l}{a}{r}{e}|{e}{n}{d}{f}{o}{r}|{e}{n}{d}{f}{o}{r}{e}{a}{c}{h}|{e}{n}{d}{i}{f}|{e}{n}{d}{s}{w}{i}{t}{c}{h}|{e}{n}{d}{w}{h}{i}{l}{e}|{e}{v}{a}{l}|{e}{x}{i}{t}|{e}{x}{t}{e}{n}{d}{s}|{f}{i}{n}{a}{l}|{f}{u}{n}{c}{t}{i}{o}{n}|{g}{l}{o}{b}{a}{l}|{g}{o}{t}{o}|{i}{m}{p}{l}{e}{m}{e}{n}{t}{s}|{i}{n}{c}{l}{u}{d}{e}"_"{o}{n}{c}{e}|{i}{n}{s}{t}{a}{n}{c}{e}{o}{f}|{i}{n}{s}{t}{e}{a}{d}{o}{f}|{i}{n}{t}{e}{r}{f}{a}{c}{e}|{i}{s}{s}{e}{t}|{l}{i}{s}{t}|{n}{a}{m}{e}{s}{p}{a}{c}{e}|{n}{e}{w}|{o}{r}|{p}{r}{i}{n}{t}|{p}{r}{i}{v}{a}{t}{e}|{p}{r}{o}{t}{e}{c}{t}{e}{d}|{p}{u}{b}{l}{i}{c}|{r}{e}{q}{u}{i}{r}{e}|{r}{e}{q}{u}{i}{r}{e}"_"{o}{n}{c}{e}|{s}{t}{a}{t}{i}{c}|{t}{h}{r}{o}{w}|{t}{r}{a}{i}{t}|{t}{r}{y}|{u}{n}{s}{e}{t}|{u}{s}{e}|{v}{a}{r})
Operadore_aritmeticos = "+"|"-"|"*"|"/"|"**"|"%"
Operadore_comparacion = "=="|"!="|">"|"<"|"<="|"=>"
Operadore_logicos = "&&"|"and"|"or"|"xor"|"||"|"!"|"&"
Operadore_adicionales = "="|"+="|"-="|"*="|"/="|"%="|".="|"."|"?"|":"|"&="|"|="|"^="|"<<="|">>="|"\|"|"^"|"<<"|">>"|"@"|"#"|"_"|"\\"|" "|"¿"|"¡"|"\""|"\'"
Aberturas = "("|"{"|"["
cierre = ")"|"}"|"]"
puntocomma = ";"
comma = ","
tipo_logicos = {t}{r}{u}{e}|{f}{a}{l}{s}{e}
decimal= [1-9][0-9]*|0
hexadecimal=0[xX][0-9a-fA-F]+
octal= 0[0-7]+
binary= 0[bB][01]+
tipo_entero = [+-]?{decimal}|[+-]?{hexadecimal}|[+-]?{octal}|[+-]?{binary}
tipo_real = [-+]?[0-9]*\.?[0-9]+([eE]{tipo_entero}.?[0-9]*)?
tipo_string = ('([^(')(\n)]|\\')*')|(\"([^(\")(\n)]|\\\")*\")
idectificador= ("_"|{texto_basico})("_"|{texto_basico})*
variables="$"{texto_basico}
errorid=({tipo_entero}{idectificador}|"$"{tipo_entero}{texto_basico})
costante={texto_basico}
estructuras_control = ({i}{f}|{e}{l}{s}{e}|{e}{l}{s}{e}{i}{f}|{e}{n}{d}{i}{f}|{w}{h}{i}{l}{e}|{d}{o}|{f}{o}{r}|{f}{o}{r}{e}{a}{c}{h}|{b}{r}{e}{a}{k}|{s}{w}{i}{t}{c}{h}|{c}{a}{s}{e}|{c}{o}{n}{t}{i}{n}{u}{e}|{r}{e}{t}{u}{r}{n}|{i}{n}{c}{l}{u}{d}{e})
variable_global = "$"({g}{l}{o}{b}{a}{l}{s}|"_"({s}{e}{r}{v}{e}{r}|{g}{e}{t}|{p}{o}{s}{t}|{f}{i}{l}{e}{s}|{c}{o}{o}{k}{i}{e}|{s}{e}{s}{s}{i}{o}{n}|{r}{e}{q}{u}{e}{s}{t}|{e}{n}{v}|{h}{t}{t}{p}"_"{r}{a}{w}"_"{p}{o}{s}{t}"_"{d}{a}{t}{a}))
varialbe_goblalm= "$"({p}{h}{p}"_"{e}{r}{r}{o}{r}{m}{s}{g}|{h}{t}{t}{p}"_"{r}{e}{s}{p}{o}{n}{s}{e}"_"{h}{e}{a}{d}{e}{r}|{a}{r}{g}{c}|{a}{r}{g}{v})
function = function
comentario_liea = ("//"|"#")(.)*
comentario_multi = (("//""*")([^(("*/"))])*("*/"))
comentario={comentario_liea}|{comentario_multi}
recordset = "$"{texto_basico}"["{tipo_string}"]"
errorcomentario=("//""*")~(\n)
errorex= ("=!=")
%{
public String lexeme;
public int lineNumber = 1;
%}
%%
[ \t\r]+ {lexeme=yytext(); return ESPACIO;}
[\n]+    { lineNumber++;lexeme=yytext(); return NUEVALINEA;}
{palabras_reservadas}  {lexeme=yytext(); return RESERWORD;}
{Operadore_aritmeticos} {lexeme=yytext();return OPE_ARI;}
{Operadore_comparacion} {lexeme=yytext();return OPE_COM;}
{Operadore_logicos} {lexeme=yytext();return OPE_LOGI;}
{Operadore_adicionales} {lexeme=yytext();return OPE_AD;}
{Aberturas} {lexeme=yytext();return OPEN;}
{cierre} {lexeme=yytext();return CLOSE;}
{puntocomma} {lexeme=yytext();return PUNTOCOMA;}
{comma} {lexeme=yytext();return COMA;}
{tipo_logicos} {lexeme=yytext();return BOOL;}
{tipo_entero} {lexeme=yytext();return INT;}
{tipo_real} {lexeme=yytext();return FLOAT;}
{tipo_string} {lexeme=yytext();return STRING;}
{idectificador} {lexeme=yytext();return ID;}
{variables} {lexeme=yytext();return VAR;}
{costante} {lexeme=yytext();return COST;}
{estructuras_control} {lexeme=yytext();return ESTRUC;}
{variable_global} {lexeme=yytext();return VARGLOBAL;}
{variable_global} {lexeme=yytext();return VARGLOBALM;}
{function} {lexeme=yytext();return FUNCTION;}
{comentario} {lexeme=yytext();return COMENT;}
{recordset} {lexeme=yytext(); return ORACLE;}
{errorid} {lexeme=yytext(); return ERROR_ID;}
{recordset} {lexeme=yytext(); return ORACLE;}
{errorid} {lexeme=yytext(); return ERROR_ID;}
{errorcomentario} {lexeme=yytext(); return ERROR_ID;}
{errorex} {lexeme=yytext(); return ERROR_ID;}
"<?php" {lexeme=yytext(); return ABRE_PHP;}
"?>"    {lexeme=yytext(); return CIERRA_PHP;} 
. {lexeme=yytext();return ERROR;}