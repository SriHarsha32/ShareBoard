<%-- 
    Document   : getUser
    Created on : Nov 11, 2016, 7:12:13 PM
    Author     : SriGanesha
--%>
<%@page import="SbUtils.RandomColor"%>
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
  String query = request.getParameter("query");
    try{
        String resHTML = "";
        Statement stmt = null;
        stmt = dbConn.createStatement();
        if(query.equals("")){
            resHTML = "<div id=\"tempAlert\" class=\"alert alert-danger\">" +
                          "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                          "<strong>ALERT!</strong> No result avialable for speicified query." +
                          "</div>";
            response.getWriter().println(resHTML);
            return;
        }
        ResultSet result = stmt.executeQuery(query);
        resHTML = "<table class=\"table restable\">";
        
        ResultSetMetaData rsmd = result.getMetaData();
        int cols = rsmd.getColumnCount();
        resHTML += ("<tr>");
        for(int i=1;i<=cols;i++){
            resHTML += ("<td>");
            resHTML += rsmd.getColumnName(i);
            resHTML += ("</td>");
        }
        resHTML += ("</tr>");
        resHTML += "<tbody>";
        while(result.next()){
            resHTML += ("<tr>");
            for(int i=1;i<=cols;i++){
                resHTML += ("<td>");
                resHTML += result.getString(i);
                resHTML += ("</td>");
            }
            resHTML += ("</tr>");
            
        }
        resHTML += "</tbody></table>";
        response.getWriter().print(resHTML);
  }
    catch(SQLException se){
        String alert = "<div id=\"tempAlert\" class=\"alert alert-danger\">" +
                          "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                          "<strong>ALERT!</strong> " + se.getLocalizedMessage()+
                          "</div>";
        response.getWriter().println(alert);
    }
  catch(Exception e) {
    String stk = "";
      for(StackTraceElement stee : e.getStackTrace()){
          stk += (stee.toString() + "\n");
      }
    response.getWriter().println("SQLException caught: " +stk+"\n ");
  }
%>
