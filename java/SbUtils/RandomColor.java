/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SbUtils;

import java.awt.Color;
import java.util.Random;

/**
 *
 * @author SriGanesha
 */
public class RandomColor {
    public static String getColor(){
        final int hue = randInt(1,360);
        return "background-color: hsl("+hue+", 56%, 38%)";
    }
    
    private static int randInt(int min, int max) {
        Random rand = new Random();
        int randomNum = rand.nextInt((max - min) + 1) + min;
        return randomNum;
    }
}
