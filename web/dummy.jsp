<%-- 
    Document   : dummy
    Created on : Nov 6, 2016, 9:09:30 PM
    Author     : SriGanesha
--%>
<%@ page import="java.sql.*"%>
<%!
	Connection dbConn=null;
        Statement stmt = null;
%>

<html>
<body>
<%
  try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();  
	dbConn=DriverManager.getConnection(  
	"jdbc:mysql://localhost:3306/SB","root","Onida-250");
    DatabaseMetaData db = dbConn.getMetaData();
    ResultSet rs = db.getTables(null, null, "%", null);
    while(rs.next()){
        response.getWriter().println(rs.getString(3));
    }
  }
  catch(SQLException e) {
    out.println("SQLException caught: " +e.getMessage());
  }
%>
</body>
</html>
