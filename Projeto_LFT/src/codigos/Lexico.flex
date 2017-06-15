package codigos;
import java_cup.runtime.Symbol;
import codigos.Sym;
import java.io.InputStream;

%%
%public
%cup

%class Lexico_Para_Sintatico_Projeto
%type java_cup.runtime.Symbol

%line
%char

%eofval{
    return new Symbol (Sym.EOF, new String("Fim do arquivo"));
%eofval}

%{

private StringBuilder str = new StringBuilder();

%}

%state COMENTARIO
%state STRING
%state COMENTARIOS

letra = [a-zA-z]
especial = [_]
digito = [0-9]
int = {digito}+ 
id = {letra} ({letra} | {digito} | especial)*
float = {digito}+ "." {digito}* | {digito}* "." {digito}+
ident = ([ ][ ][ ][ ])
ident2 = ([ ][ ][ ][ ])+


%%
<YYINITIAL>{
    "if" {return new Symbol (Sym.IF, yyline, yycolumn,"if");}
    "elif" {return new Symbol (Sym.ELIF, yyline, yycolumn,"elif"); }
    "else" {return new Symbol (Sym.ELSE, yyline, yycolumn,"else"); }
    "while" {return new Symbol (Sym.WHILE, yyline, yycolumn,"while");}
    "for" {return new Symbol (Sym.FOR, yyline, yycolumn,"for");}
    "break" {return new Symbol (Sym.BREAK, yyline, yycolumn,"break");}
    "range" {return new Symbol (Sym.RANGE, yyline, yycolumn, "range");}

    "input" {return new Symbol (Sym.INPUT, yyline, yycolumn,"input");}
    "print" {return new Symbol (Sym.PRINT, yyline, yycolumn,"print");}

    "def" {return new Symbol (Sym.DEF, yyline, yycolumn,"def");}
    "return" {return new Symbol (Sym.RETORNO, yyline, yycolumn,"return");}
    "pass" {return new Symbol (Sym.PASS, yyline, yycolumn,"pass");}

    "not" {return new Symbol (Sym.NOT, yyline, yycolumn,"not");}
    "or" {return new Symbol (Sym.OR, yyline, yycolumn,"or");}
    "and" {return new Symbol (Sym.AND, yyline, yycolumn,"and");}
    "in" {return new Symbol (Sym.IN, yyline, yycolumn,"in");}
    "is" {return new Symbol (Sym.IS, yyline, yycolumn,"is");}
    "is not" {return new Symbol (Sym.NOT, yyline, yycolumn,"is not");}
    "not in" {return new Symbol (Sym.NOTIN, yyline, yycolumn,"not in");}

    "+" {return new Symbol (Sym.MAIS, yyline, yycolumn,"+");}
    "-" {return new Symbol (Sym.MENOS, yyline, yycolumn,"-");}
    "*" {return new Symbol (Sym.VEZES, yyline, yycolumn,"*");}
    "/" {return new Symbol (Sym.DIVISAO, yyline, yycolumn,"//");}
    "%" {return new Symbol (Sym.PORCENTAGEM, yyline, yycolumn,"%");}
    "(" {return new Symbol (Sym.PARESQ, yyline, yycolumn,"(");}
    ")" {return new Symbol (Sym.PARDIR, yyline, yycolumn,")");}
    ":" {return new Symbol (Sym.DOISPONTOS, yyline, yycolumn,":");}
    "=" {return new Symbol (Sym.IGUAL, yyline, yycolumn,"=");}
    "," {return new Symbol (Sym.VIRGULA, yyline, yycolumn,",");}

    "==" {return new Symbol (Sym.DOISIGUAIS, yyline, yycolumn,"==");}
    ">" {return new Symbol (Sym.MAIORQ, yyline, yycolumn,">");}
    "<" {return new Symbol (Sym.MENORQ, yyline, yycolumn,"<");}
    "!=" {return new Symbol (Sym.DIFERENTE, yyline, yycolumn,"!=");}
    "<=" {return new Symbol (Sym.MENORIGUALQ, yyline, yycolumn,"<=");}
    ">=" {return new Symbol (Sym.MAIORIGUALQ, yyline, yycolumn,">=");}
    "+=" {return new Symbol (Sym.CONCATENACAO, yyline, yycolumn,"+=");}
    
    "False" {return new Symbol (Sym.FALSO, yyline, yycolumn,"False");}
    "True" {return new Symbol (Sym.TRUE, yyline, yycolumn,"True");}
    "\n" {return new Symbol (Sym.NEWLINE, yyline, yycolumn,"New Line");}
    
    {float} {return new Symbol (Sym.FLOAT, yyline, yycolumn, yytext());}
    {id} {return new Symbol (Sym.ID, yyline, yycolumn, yytext());}
    {int} {return new Symbol (Sym.INT, yyline, yycolumn, yytext());}
    
    {ident} {return new Symbol (Sym.IDENT, yyline, yycolumn, "IDENTACAO");}
    {ident2} {return new Symbol (Sym.IDENT, yyline, yycolumn, "IDENTACAO2");}
    

    "'''" {str.setLength(0) ;  yybegin(COMENTARIOS); }
    "#" { str.setLength(0) ; yybegin(COMENTARIO); }
    \" {str.setLength(0); yybegin(STRING); }
    
    [\r]+ { /* do nothing */ }
    [\ ]+ {/* do nothing */}
    [\t]+ {/* do nothing */}
    <<EOF>> { return new Symbol(Sym.EOF); }
    . {}

}

<COMENTARIOS> {
    "'''" { { yybegin(YYINITIAL);  
             return new Symbol(Sym.COMENTARIOS,str.toString()); } } 
    [ \n\r\t] { str.append(yytext()); }
    <<EOF>> {  yybegin(YYINITIAL); }
    . { str.append(yytext());  }
}

<COMENTARIO> {
    "\n" {{ yybegin(YYINITIAL);  
        return new Symbol(Sym.COMENTARIO,str.toString()); } } 
    <<EOF>> {  yybegin(YYINITIAL); }
    . { str.append(yytext()); }
}

<STRING> {
    \" { yybegin(YYINITIAL); return new Symbol(Sym.STRING,str.toString()); }
    [^\n\r\\] { str.append(yytext()); }
    <<EOF>> { yybegin(YYINITIAL);  }
    . { yybegin(YYINITIAL);  }
}


