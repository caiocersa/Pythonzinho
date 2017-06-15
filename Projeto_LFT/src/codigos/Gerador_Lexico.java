package codigos;

import java.io.File;
import jflex.Main;

public class Gerador_Lexico {

    public static void main(String[] args) {
    Main.generate(new File("src\\codigos\\Lexico2.flex"));
    }
    
}
