<%-- 
    Document   : getUser
    Created on : Nov 11, 2016, 7:12:13 PM
    Author     : SriGanesha
--%>
<%@page import="SbUtils.Changer"%>
<%@ page import="java.sql.*"%>
<%@ page session="true" %>
<%!
	Connection dbConn=null;
%>
<%
  try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();  
	dbConn=DriverManager.getConnection(  
	"jdbc:mysql://localhost:3306/SB","root","Onida-250");
  }
  catch(SQLException e) {
    out.println("SQLException caught: " +e.getMessage());
  }
  //String user = session.getAttribute("user").toString();
  String notiftype = request.getParameter("type");
    try{
        String resHTML = "";
        Statement stmt = null;
        switch(notiftype){
            case "notifs":
                try{
                    stmt = dbConn.createStatement();
                    String getShareNotifsSQL = "SELECT fullname,sharedon FROM `postnotif` P,`userdetails` U WHERE U.username=P.username ORDER BY sharedon DESC";
                    ResultSet result = stmt.executeQuery(getShareNotifsSQL);

                    while(result.next()){
                        resHTML += "<div class=\"notif\"><b>"+result.getString(1)+"</b> posted a share."
                                    + "<span class=\"time\">"+Changer.ChangeTime(result.getString(2), "hh:mm:ss a")+"</span>"
                                    + "</div>";
                    }
                }
                catch(SQLException se){
                    String alert = "<div id=\"tempAlert\" class=\"alert alert-danger\">" +
                                  "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                                  "<strong>ALERT!</strong> " + se.getLocalizedMessage()+
                                  "</div>";
                response.getWriter().println(alert);
                }

                try{
                    stmt = dbConn.createStatement();
                    String getCmntNotifsSQL = "SELECT Sharer,Commtr,cmntOn FROM commentnotif ORDER BY cmntOn DESC";
                    ResultSet result = stmt.executeQuery(getCmntNotifsSQL);

                    while(result.next()){
                        String sharer = result.getString("Sharer");
                        String commtr = result.getString("Commtr");
                        if(sharer.equals(commtr)){
                            resHTML += "<div class=\"notif\"><b>"+sharer+"</b> commented on his own share.</b>"
                                    + "<span class=\"time\">"+Changer.ChangeTime(result.getString("cmntOn"), "hh:mm:ss a")+"</span>"
                                    + "</div>";
                        }
                        else{
                            resHTML += "<div class=\"notif\"><b>"+commtr+"</b> commented on a share posted by <b>"+sharer+".</b>"
                                        + "<span class=\"time\">"+Changer.ChangeTime(result.getString("cmntOn"), "hh:mm:ss a")+"</span>"
                                        + "</div>";
                        }
                    }
                }
                catch(SQLException se){
                    String alert = "<div id=\"tempAlert\" class=\"alert alert-danger\">" +
                                  "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                                  "<strong>ALERT!</strong> " + se.getLocalizedMessage()+
                                  "</div>";
                    response.getWriter().println(alert);
                }
                response.getWriter().println(resHTML);
            break;
            case "reports":
                try{
                    stmt = dbConn.createStatement();
                    String getRepsSQL = "SELECT MAX(cnt),RType,S.STitle FROM (SELECT COUNT(*) as cnt,RType,Sid FROM reactions GROUP BY RType,Sid) as tmp, shares S WHERE tmp.Sid=S.ShareId GROUP BY RType";
                    ResultSet result = stmt.executeQuery(getRepsSQL);

                    while(result.next()){
                        int maxcnt = result.getInt(1);
                        String type = result.getString(2);
                        String title = result.getString(3);
                        String text = "";
                        switch(type){
                            case "Like": text= "Most liked share:"; break;
                            case "Love": text= "Most loved share:"; break;
                            case "Sad": text= "Saddest share:"; break;
                            case "Haha": text= "Funniest share:"; break;
                            case "Wow": text= "Most astonished share:"; break;
                            case "Angry": text= "Most frustrated share:"; break;
                        }
                        resHTML = "<div class=\"myPanel panel-body\">"
                                   +"<div class=\"trnd-"+type.toLowerCase()+" text-center\"></div>"
                                   +"<div style=\"padding-left:41px;\">"
                                   +text+ "("+maxcnt+") <strong>"+ title + "</strong>"  
                                   +"</div></div>";
                        response.getWriter().println(resHTML);
                    }
                }
                catch(SQLException se){
                    String alert = "<div id=\"tempAlert\" class=\"alert alert-danger\">" +
                                  "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                                  "<strong>ALERT!</strong> " + se.getLocalizedMessage()+
                                  "</div>";
                    response.getWriter().println(alert);
                }

                /*try{
                    stmt = dbConn.createStatement();
                    String getCmntNotifsSQL = "SELECT Sharer,Commtr,cmntOn FROM commentnotif ORDER BY cmntOn DESC";
                    ResultSet result = stmt.executeQuery(getCmntNotifsSQL);

                    while(result.next()){
                        String sharer = result.getString("Sharer");
                        String commtr = result.getString("Commtr");
                        if(sharer.equals(commtr)){
                            resHTML += "<div class=\"notif\"><b>"+sharer+"</b> commented on his own share.</b>"
                                    + "<span class=\"time\">"+Changer.ChangeTime(result.getString("cmntOn"), "hh:mm:ss a")+"</span>"
                                    + "</div>";
                        }
                        else{
                            resHTML += "<div class=\"notif\"><b>"+commtr+"</b> commented on a share posted by <b>"+sharer+".</b>"
                                        + "<span class=\"time\">"+Changer.ChangeTime(result.getString("cmntOn"), "hh:mm:ss a")+"</span>"
                                        + "</div>";
                        }
                    }
                }
                catch(SQLException se){
                    String alert = "<div id=\"tempAlert\" class=\"alert alert-danger\">" +
                                  "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                                  "<strong>ALERT!</strong> " + se.getLocalizedMessage()+
                                  "</div>";
                    response.getWriter().println(alert);
                }*/
                break;
        }
        //response.getWriter().print(resHTML);
  }
  catch(Exception e) {
    String stk = "";
      for(StackTraceElement stee : e.getStackTrace()){
          stk += (stee.toString() + "\n");
      }
    response.getWriter().println("SQLException caught: " +stk+"\n ");
  }
%>
