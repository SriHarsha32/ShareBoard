/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SbUtils;

import java.text.SimpleDateFormat;

/**
 *
 * @author SriGanesha
 */
public class Changer {
    public static String ChangeDate(String date,String from,String to){
        try{
            SimpleDateFormat sdfmt2 = new SimpleDateFormat(to);
            SimpleDateFormat sdfmt1= new SimpleDateFormat(from);
            java.util.Date dDate = sdfmt1.parse(date);
            String newDOB = sdfmt2.format( dDate );
            return newDOB;
        }
        catch(Exception e){
            return date;
        }
    }
    
    public static String ChangeTime(String time,String to){
        try{
            SimpleDateFormat sdfmt2 = new SimpleDateFormat(to);
            SimpleDateFormat sdfmt1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date oTime = sdfmt1.parse(time);
            String newTime = sdfmt2.format( oTime );
            return newTime;
        }
        catch(Exception e){
            return time;
        }
    }
    
}
