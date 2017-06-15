package codigos;

%%
%class Lexico_Projeto
%type Token
%line
%column
%public

%{
public Token token(Token.T type)
{
return new Token(type, yyline, yycolumn);
}
public Token token(Token.T type, Object val)
{
return new Token(type, val, yyline, yycolumn);
}
public boolean isFini(){
        return zzAtEOF;
}
int cont;
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
    "if" { return token(Token.T.IF); }
    "elif" { return token(Token.T.ELIF); }
    "else" { return token(Token.T.ELSE); }
    "switch" { return token(Token.T.SWITCH); }
    "while" { return token(Token.T.WHILE); }
    "for" { return token(Token.T.FOR); }
    "break" { return token(Token.T.BREAK); }
    "continue" { return token(Token.T.CONTINUE); }
    "range" { return token(Token.T.RANGE); }

    "input" { return token(Token.T.INPUT); }
    "print" { return token(Token.T.PRINT); }

    "def" { return token(Token.T.DEF); }
    "return" { return token(Token.T.RETORNO); }
    "pass" { return token(Token.T.PASS); }

    "not" { return token(Token.T.NOT); }
    "or" { return token(Token.T.OR); }
    "and" { return token(Token.T.AND); }
    "in" { return token(Token.T.IN); }
    "is" { return token(Token.T.IS); }
    "is not" { return token(Token.T.ISNOT); }
    "not in" { return token(Token.T.NOTIN); }

    "+" { return token(Token.T.MAIS); }
    "-" { return token(Token.T.MENOS); }
    "*" { return token(Token.T.VEZES); }
    "/" { return token(Token.T.DIVISAO); }
    "%" { return token(Token.T.PORCENTAGEM); }
    "(" { return token(Token.T.PARESQ); }
    ")" { return token(Token.T.PARDIR); }
    ":" { return token(Token.T.DOISPONTO); }
    "=" { return token(Token.T.IGUAL); }
    "," { return token(Token.T.VIRGULA); }

    "==" { return token(Token.T.DOISIGUAIS); }
    ">" { return token(Token.T.MAIORQ); }
    "<" { return token(Token.T.MENORQ); }
    "!=" { return token(Token.T.DIFERENTE); }
    "<=" { return token(Token.T.MENORIGUALQ); }
    ">=" { return token(Token.T.MAIORIGUALQ); }
    "+=" { return token(Token.T.CONCATENACAO); }
    
    "False" {return token(Token.T.FALSE);}
    "True" {return token(Token.T.TRUE);}
    "\n" { return token(Token.T.NEWLINE); }

    {float} { return token(Token.T.FLOAT, new Double(yytext())); }
    {id} { return token(Token.T.ID,yytext()); }
    {int} { return token(Token.T.INT, new Integer(yytext())); }

    {ident} {return token(Token.T.IDENT);}
    {ident2} {return token(Token.T.IDENT2);}

    "'''" {str.setLength(0) ;  yybegin(COMENTARIOS); }
    "#" { str.setLength(0) ;  yybegin(COMENTARIO); }
    \" {str.setLength(0);  yybegin(STRING); }

    [\r]+ { /* do nothing */ }
    [\ ]+ {}
    [\t]+ {}
    <<EOF>> { return token(Token.T.EOF); }
    . { return token(Token.T.ERRO); }

}

<COMENTARIOS> {
    "'''" { { yybegin(YYINITIAL);  
             return token(Token.T.COMENTARIOS,str.toString()); } } 
    [ \n\r\t] { str.append(yytext());}
    <<EOF>> {  yybegin(YYINITIAL); {return token(Token.T.ERRO); }}
    . { str.append(yytext()); }
}

<COMENTARIO> {
    "\n" {{ yybegin(YYINITIAL);  
        return token(Token.T.COMENTARIO,str.toString()); } } 
    <<EOF>> {  yybegin(YYINITIAL); {return token(Token.T.ERRO); }}
    . { str.append(yytext()); }
}

<STRING> {
    \" { yybegin(YYINITIAL); return token(Token.T.STRING,str.toString()); }
    [^\n\r\\] { str.append(yytext()); }
    <<EOF>> { yybegin(YYINITIAL); {return token(Token.T.ERRO);} }
    . { yybegin(YYINITIAL); {return token(Token.T.ERRO);} }
}

