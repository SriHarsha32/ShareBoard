/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SbUtils;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author SriGanesha
 */
public class URLGetter {
    public static String getTitle(String url){
        InputStream response = null;
            try {
                response = new URL(url).openStream();


                Scanner scanner = new Scanner(response);
                String responseBody = scanner.useDelimiter("\\A").next();

                // new algorithm
                final Pattern pattern = Pattern.compile("<title .*>(.+?)</title>");
                final Matcher matcher = pattern.matcher(responseBody);
                matcher.find();
                if(matcher.matches())
                    return (matcher.group(1));
                else
                    return (responseBody.substring(responseBody.indexOf("<title>") + 7, responseBody.indexOf("</title>")));

            } catch (IOException ex) {
                
            } finally {
                try {
                    response.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
        return "";
    }
}
