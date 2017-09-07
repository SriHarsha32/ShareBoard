<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*"%>
<%@ page session="true" %>
<%!
	Connection dbConn=null;
        Statement stmt = null;
        String resultString = "";
%>

<html>
<body>
<%!
	int numRows(ResultSet rs){
		int x=0;
		try{
			rs.last();
			x = rs.getRow();
			rs.beforeFirst();
		}
		catch(Exception e){
			//out.println("SQLException caught: " +e.getMessage());
		}
		return x;
	}
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
  
    String outType = request.getParameter("page");
    String fullname = request.getParameter("fullname");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String dob = request.getParameter("dob");
    SimpleDateFormat sdfmt1 = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat sdfmt2= new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date dDate = sdfmt1.parse(dob);
    String newDOB = sdfmt2.format( dDate )+" 00:00:00";
    String password = request.getParameter("password");
    String gender = request.getParameter("gender");
    stmt = dbConn.createStatement();
    
  switch(outType){
      case "login":
          
                String interests[]= request.getParameterValues("interest");

                try{
                        
                        PreparedStatement pstmt = null;
                        String finduserSQL = "SELECT username FROM userdetails WHERE username='"+username+"'";
                        String findemailSQL = "SELECT email FROM userdetails WHERE email='"+email+"'";
                        String insertUserSQL = "INSERT INTO userdetails VALUES (?,?,?,?,?);";
                        String insertLogSQL = "INSERT INTO login VALUES (?,?)";
                        String insertIntrstSQL = "INSERT INTO typesconfig VALUES (?,?)";
                        if(numRows(stmt.executeQuery(findemailSQL))>0){
                                response.getWriter().println("Email address already registered");
                                resultString = "Email address already registered";
                        }
                        else if(numRows(stmt.executeQuery(finduserSQL))>0){
                                response.getWriter().println("Username already exists");
                                resultString = "Username already exists";
                        }
                        else{
                                pstmt = dbConn.prepareStatement(insertUserSQL);
                                pstmt.setString(1, fullname);
                                pstmt.setString(2, username);
                                pstmt.setString(3, email);
                                pstmt.setString(4, newDOB);
                                pstmt.setString(5, gender);
                                pstmt.executeUpdate();

                                pstmt = dbConn.prepareStatement(insertLogSQL);
                                pstmt.setString(1, username);
                                pstmt.setString(2, password);
                                pstmt.executeUpdate();

                                for(int i=0;i<interests.length;i++){
                                      pstmt = dbConn.prepareStatement(insertIntrstSQL);
                                      pstmt.setString(1, username);
                                      pstmt.setInt(2, Integer.parseInt(interests[i]));
                                      pstmt.executeUpdate();
                                }

                                response.getWriter().println("Registered successfully.");
                                resultString = "Registration successfull. You can now login";
                        }
                }
                catch(SQLException e) {
                  out.println("SQLException caught: " +e.toString()+"\n ");
                }
                application.setAttribute("Response", resultString);
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "login.jsp");
          break;
      case "settings":
                String interestStr = request.getParameter("interests");
                String oldUser = session.getAttribute("user").toString();
                try{
                        //stmt = dbConn.createStatement();
                        PreparedStatement pstmt = null;
                        String updateUserSQL = "UPDATE userdetails SET fullname= ?, email=?, dob=?, gender=? WHERE username='"+oldUser+"'";
                        String updateLogSQL = "UPDATE login SET pass=? WHERE username='"+oldUser+"'";
                        String insertIntrstSQL = "INSERT INTO typesconfig VALUES (?,?)";
                        String deleteIntrstSQL = "DELETE FROM typesconfig WHERE username='"+oldUser+"'";
                        pstmt = dbConn.prepareStatement(updateUserSQL);
                        pstmt.setString(1, fullname);
                        pstmt.setString(2, email);
                        pstmt.setString(3, newDOB);
                        pstmt.setString(4, gender.substring(0, 1));
                        pstmt.executeUpdate();

                        pstmt = dbConn.prepareStatement(updateLogSQL);
                        pstmt.setString(1, password);
                        pstmt.executeUpdate();

                        stmt = dbConn.createStatement();
                        stmt.executeUpdate(deleteIntrstSQL);

                        interests = interestStr.split(",");
                        for(int i=0;i<interests.length;i++){
                              pstmt = dbConn.prepareStatement(insertIntrstSQL);
                              pstmt.setString(1, username);
                              pstmt.setInt(2, Integer.parseInt(interests[i]));
                              pstmt.executeUpdate();
                        }

                        response.getWriter().println("User details successfully updated.");
                        resultString = "Registration successfull. You can now login";
                }
                catch(SQLException e) {
                  out.println("SQLException caught: " +e.toString()+"\n ");
                }
                application.setAttribute("Response", resultString);
                //response.setStatus(response.SC_MOVED_TEMPORARILY);
                //response.setHeader("Location", "login.jsp");
          break;
  }
  
   
%>
</body>
</html>