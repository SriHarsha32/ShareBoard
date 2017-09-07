<%-- 
    Document   : addReact
    Created on : Nov 10, 2016, 7:56:29 PM
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
        String action = request.getParameter("action");
        String SID = request.getParameter("ShareId").substring(5);
        
        String user = session.getAttribute("user").toString();
        String type = "";
        PreparedStatement pstmt = null;
        Statement stmt = null;
        ResultSet rs = null;
        switch(action){
            case "deleteReact":
                String deleteReactSQL = "DELETE FROM reactions WHERE Sid="+SID+" AND username='"+user+"'";
                stmt = dbConn.createStatement();
                stmt.execute(deleteReactSQL);
                response.getWriter().println("Reaction deleted successfully.");
                break;
            case "updateReact":
                String getReactSQL = "SELECT * FROM reactions WHERE Sid="+SID+" AND username='"+user+"'";
                stmt = dbConn.createStatement();
                rs = stmt.executeQuery(getReactSQL);
                if(rs.next()){
                    type = request.getParameter("RType");
                    String updateReactSQL = "UPDATE reactions SET RType='"+type+"' WHERE Sid="+SID+" AND username='"+user+"'";
                    stmt = dbConn.createStatement();
                    stmt.executeUpdate(updateReactSQL);
                    response.getWriter().println("Reaction updated successfully.");
                }
                else{
                    type = request.getParameter("RType");
                    String insertReactSQL = "INSERT INTO reactions(RType,Sid,username) VALUES (?,?,?);";
                    pstmt = dbConn.prepareStatement(insertReactSQL);
                    pstmt.setString(1, type);
                    pstmt.setInt(2, Integer.parseInt(SID));
                    pstmt.setString(3, user);
                    pstmt.executeUpdate();
                    response.getWriter().println("Reaction successfully.");
                }
                break;
            case "deletePost":
                String deletePostSQL = "DELETE FROM shares WHERE ShareId="+SID+" AND username='"+user+"'";
                stmt = dbConn.createStatement();
                stmt.execute(deletePostSQL);
                response.getWriter().println("Post deleted successfully.");
                break;
        }   
  }
  catch(Exception e) {
    out.println("Exception caught: " +e.toString()+"\n "+e.getLocalizedMessage());
  }
%>