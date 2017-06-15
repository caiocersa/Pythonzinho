package codigos;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.util.Formatter;
import views.Tela_Principal;

public class Token {

    public T type;
    public enum T {IF(2),ELIF(3), ELSE(4), SWITCH(5), WHILE(6),FOR(7),BREAK(8),CONTINUE(9),
                   TYPE(10), INPUT(11), PRINT(12), 
                   DEF(13), RETORNO(14), PASS(15),
                   NOT(16),OR(17),AND(18),IN(19),IS(20),ISNOT(21),NOTIN(22),END(23),
                   MAIS(24),MENOS(25),VEZES(26),DIVISAO(27),PORCENTAGEM(28),DOISIGUAIS(29),PARESQ(30),PARDIR(31),DOISPONTO(32),
                   IGUAL(33),MAIORQ(34),MENORQ(35),DIFERENTE(36),MENORIGUALQ(37),MAIORIGUALQ(38),CONCATENACAO(39),
                   FLOAT(40),INT(41),ID(42),STRING(43),
                   COMENTARIO(44),COMENTARIOS(45),
                   VIRGULA(46),ERRO(47),RANGE(48),IDENT(49),IDENT2(50),NEWLINE(51),FALSE(52),TRUE(53),EOF(0);
                   
        
    private final int v;
	T(int valorOpcao){
		v = valorOpcao;
	}
	public int getValor(){
		return v;
        }
	};
    
    
    public Object val;
    public int line;
    public int col;

    public Token(T type, int line, int col) {
        this.type = type;
        this.line = line;
        this.col = col;
    }

    public Token(T type, Object val, int line, int col) {
        this.type = type;
        this.val = val;
        this.line = line;
        this.col = col;
    }

    public String toString() {
        
        Formatter out = new Formatter();
        out.format("Token [ %s ] ---> Linha: %d / Coluna: %d", type, line, col);
        if (val != null) {
            out.format(" / Lexema [ %s ]", val);
        }
        return out.toString();
        
    }
}