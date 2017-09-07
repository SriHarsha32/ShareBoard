<%-- 
    Document   : addComment
    Created on : Nov 10, 2016, 11:56:23 PM
    Author     : SriGanesha
--%>
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
  try{
        String SID = request.getParameter("ShareId").substring(5);
        String cmnt = request.getParameter("Comment");
        String user = session.getAttribute("user").toString();
        String insertCommentSQL = "INSERT INTO comments (Comment,Sid,username) VALUES (?,?,?);";
        PreparedStatement pstmt = dbConn.prepareStatement(insertCommentSQL);
        pstmt.setString(1, cmnt);
        pstmt.setInt(2, Integer.parseInt(SID));
        pstmt.setString(3, user);
        pstmt.executeUpdate();
        response.getWriter().println("Comment successfully.");
  }
  catch(Exception e) {
    out.println("Exception caught: " +e.toString()+"\n "+e.getLocalizedMessage());
  }
%>
