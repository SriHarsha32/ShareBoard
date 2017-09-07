<%-- 
    Document   : signin
    Created on : Nov 7, 2016, 8:41:54 PM
    Author     : SriGanesha
--%>
<%@ page import="java.sql.*"%>
<%@ page session="true" %>
<%!
	Connection dbConn=null;
        Statement stmt = null;
        String resultString = "";
        boolean success = false;
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
  String username = request.getParameter("username");
  String password = request.getParameter("password");
  
  try{
      
	stmt = dbConn.createStatement();
	String finduserSQL = "SELECT * FROM login WHERE username='"+username+"'";
        ResultSet rs = stmt.executeQuery(finduserSQL);
        if(!rs.first()){
            // user not registered
            resultString = "User not registered.";
        }
        else{           
            String pass = rs.getString("pass");
            if(pass.equals(password)){
                // successfull login
                resultString = "Login successfull.";
                success = true;
                session.setAttribute("user", username);
            }
            else{
                resultString = "Password not correct.";
            }
        }
  }
  catch(SQLException e) {
    out.println("SQLException caught: " +e.toString()+"\n ");
  }
  application.setAttribute("Response", resultString);
  response.setStatus(response.SC_MOVED_PERMANENTLY);
  if(!success)
      response.setHeader("Location", "login.jsp"); 
  else
      response.setHeader("Location", "index.jsp");
%>
