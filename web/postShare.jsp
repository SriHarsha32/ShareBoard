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
        String ttl = request.getParameter("ttl");
        String body = request.getParameter("body");
        String hash[] = new String[5];
        hash[0] = request.getParameter("hash1");
        hash[1] = request.getParameter("hash2");
        hash[2] = request.getParameter("hash3");
        hash[3] = request.getParameter("hash4");
        hash[4] = request.getParameter("hash5");
        String link = request.getParameter("slink");
        String type = request.getParameter("catgry");
        int category = 0;
        switch(type){
              case "Sports": category=1;break;
              case "Entertainment": category=2;break;
              case "Politics": category=3;break;
              case "Education": category=4;break;
              case "Technology": category=5;break;
              case "Travel": category=6;break;
          }
        String user = session.getAttribute("user").toString();
        boolean islink = false;
        if(link != null && !link.equals("xnull"))
            islink = true;
        PreparedStatement pstmt = null;
        String insertShareSQL = "INSERT INTO shares(SType,STitle,SBody,username) VALUES (?,?,?,?);";
        if(islink)
            insertShareSQL = "INSERT INTO shares(SType,STitle,SBody,username,SLink) VALUES (?,?,?,?,?);";
        pstmt = dbConn.prepareStatement(insertShareSQL);
        pstmt.setInt(1, category);
        pstmt.setString(2, ttl);
        pstmt.setString(3, body);
        pstmt.setString(4, user);
        if(islink)
            pstmt.setString(5, link);
        pstmt.executeUpdate();
        ResultSet rs = dbConn.createStatement().executeQuery("select last_insert_id() as last_id from shares");
        rs.next();
        int ShareId = rs.getInt("last_id");

        for(int i=0;i<5;i++){
            if(hash[i] != null && !hash[i].equals("xnull")){
                String insertHashSQL = "INSERT IGNORE INTO hashtag(hashName) VALUES (?)";
                pstmt = dbConn.prepareStatement(insertHashSQL);
                pstmt.setString(1, hash[i]);
                pstmt.executeUpdate();

                String selectHash = "SELECT * FROM hashtag WHERE hashName='"+hash[i]+"'";
                rs = dbConn.createStatement().executeQuery(selectHash);
                rs.next();
                int HashId = rs.getInt("hashid");

                String insertHashShareSQL = "INSERT INTO hashshares(hashid,Shareid) VALUES (?,?)";
                pstmt = dbConn.prepareStatement(insertHashShareSQL);
                pstmt.setInt(1, HashId);
                pstmt.setInt(2, ShareId);
                pstmt.executeUpdate();
            }
        }
        response.getWriter().println("Share posted successfully.");
        
  }
  catch(Exception e) {
    out.println("Exception caught: " +e.toString()+"\n "+e.getLocalizedMessage());
  }
%>