/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package miniphp;

import java.io.File;
import java.io.IOException;

/**
 *
 * @author keviu
 */
public class MiniPHP {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        String path =  "C:/Users/keviu/Documents/Ciclo 5/Lenguajes/Proyecto/Proyecto-PHP-lexico/MiniPHP/src/miniphp/Lexer.flex";
        generarLexer(path);
        LexicalForm formulario=new LexicalForm();
        formulario.setVisible(true);
        

    }
    public static void generarLexer(String path){
        File file=new File(path);
        jflex.Main.generate(file);
    }
    
}
