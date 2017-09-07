<%-- 
    Document   : getUser
    Created on : Nov 11, 2016, 7:12:13 PM
    Author     : SriGanesha
--%>
<%@page import="SbUtils.Changer"%>
<%@page import="java.text.SimpleDateFormat"%>
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
  String user = session.getAttribute("user").toString();
  String outType = request.getParameter("page");
    try{
        Statement stmt = null;
        String getShareSQL = "SELECT * FROM userdetails U WHERE U.username='"+user+"'";
        stmt = dbConn.createStatement();
        ResultSet shares = stmt.executeQuery(getShareSQL);
        if(shares.next()){
            String fullname = shares.getString("fullname");
            String newDOB = Changer.ChangeDate(shares.getString("dob"), "yyyy-MM-dd", "dd-MM-yyyy");
            String gender = shares.getString("gender");
            String email = shares.getString("email");
            
            String getIntsSQL = "SELECT tname FROM types WHERE tid IN (SELECT tid FROM typesconfig WHERE username='"+user+"')";
            stmt = dbConn.createStatement();
            ResultSet ints = stmt.executeQuery(getIntsSQL);
            String interests = "";
            while(ints.next()){
                interests += ints.getString("tname");
                interests += "<br>";
            }
            if(interests.length() > 4)
                interests = interests.substring(0, interests.length()- 4);
            else
                interests = "None";
            
            String getPassSQL = "SELECT pass FROM login WHERE username='"+user+"'";
            stmt = dbConn.createStatement();
            String password ="";
            ResultSet passes = stmt.executeQuery(getPassSQL);
            if(passes.next()){
                password = passes.getString("pass");
            }
            
            
            // call procedures 
            String getCmnt = "{call getUserCmnts (?, ?)}";
            CallableStatement cst = dbConn.prepareCall(getCmnt);
            cst.setString(1, user);
            cst.registerOutParameter(2, java.sql.Types.INTEGER);
            cst.execute();
            String cmntsCnt = ("Comments: <strong>"+cst.getInt(2)+"</strong>");
            
            String getReacts = "{call getUserReacts (?, ?)}";
            cst = dbConn.prepareCall(getReacts);
            cst.setString(1, user);
            cst.registerOutParameter(2, java.sql.Types.INTEGER);
            cst.execute();
            String reactsCnt = ("Reactions: <strong>"+cst.getInt(2)+"</strong>");
            
            String getShares = "{call getUserShares (?, ?)}";
            cst = dbConn.prepareCall(getShares);
            cst.setString(1, user);
            cst.registerOutParameter(2, java.sql.Types.INTEGER);
            cst.execute();
            String sharesCnt = ("Shares: <strong>"+cst.getInt(2)+"</strong>");
            
            
            String outHTML = "";
            switch(outType){
                case "account":
                    String tableHTML = "<div class=\"panel panel-info\">"
                            + "<div class=\"panel-heading\">"
                            + "<h3 class=\"panel-title\">"+fullname+"</h3>"
                            + "</div>"
                            + "<div class=\"panel-body\">"
                            + "<div class=\"row\">"
                            + "<div class=\"col-md-3 col-lg-3 \" align=\"center\">"
                            + "<div class=\"img-circle avatar sports\" style=\""+RandomColor.getColor()+";\">"+fullname.charAt(0)+"</div>"
                            + "</div>"
                            + "<div class=\" col-md-9 col-lg-9 \">"
                            + "<table class=\"table table-user-information\">"
                            + "<tbody>"
                            + "<tr>"
                            + "<td>Name:</td>"
                            + "<td>"+fullname+"</td>"
                            + "</tr><tr>"
                            + "<td>Date of Birth:</td>"
                            + "<td>"+newDOB+"</td>"
                            + "</tr><tr>"
                            + "<td>Gender:</td>"
                            + "<td>"+gender+"</td>"
                            + "</tr><tr>"
                            + "<td>User ID:</td>"
                            + "<td>"+user+"</td>"
                            + "</tr><tr>"
                            + "<td>Email:</td>"
                            + "<td><a href=\"mailto:"+email+"\">"+email+"</a></td>"
                            + "</tr><tr>"
                            + "<td>Activites:</td>"
                            + "<td>"+sharesCnt+"<br>"+cmntsCnt+"<br>"+reactsCnt
                            + "</td></tr><tr>"
                            + "<td>Interested topics:</td>"
                            + "<td>"+interests+"</td>"
                            + "</tr><tr><td></td><td></td></tr>"
                            + "</tbody></table></div></div></div></div>"; 
                    outHTML = tableHTML;
                    break;
                case "settings":
                    String formHTML ="<form class=\"form-horizontal\" role=\"form\">"
                    + "<div class=\"form-group\">"
                    + "<label class=\"col-md-3 control-label\">Name:</label>"
                    + "<div class=\"col-md-8\">"
                    + "<input id=\"FullName\" class=\"form-control\" type=\"text\" value=\""+fullname+"\">"
                    + "</div>"
                    + "</div>"
                    + "<div class=\"form-group\">"
                    + "<label class=\"col-md-3 control-label\">Gender:</label>"
                    + "<div class=\"col-md-8\">"
                    + "<div class=\"ui-select\">"
                    + "<select id=\"gender\" class=\"form-control\">"
                    + "<option value=\"Male\" "+(gender.equals("M")? "selected": "")+">Male</option>"
                    + "<option value=\"Female\" "+(gender.equals("F")? "selected": "")+">Female</option>"
                    + "</select>"
                    + "</div>"
                    + "</div>"
                    + "</div>"
                    + "<div class=\"form-group\">"
                    + "<label class=\"col-md-3 control-label\">Email:</label>"
                    + "<div class=\"col-md-8\">"
                    + "<input id=\"email\" class=\"form-control\" type=\"text\" value=\""+email+"\">"
                    + "</div></div>"
                    + "<div class=\"form-group\">"
                    + "<label class=\"col-md-3 control-label\">Date of Birth:</label>"
                    + "<div class=\"col-md-8\">"
                    + "<input id=\"dob\" class=\"form-control\" type=\"text\" value=\""+newDOB+"\">"
                    + "</div>"
                    + "</div>"
                    + "<div class=\"form-group\">"
                    + "<label class=\"col-md-3 control-label\">User ID:</label>"
                    + "<div class=\"col-md-8\">"
                    + "<input id=\"UserName\" class=\"form-control\" type=\"text\" value=\""+user+"\"  disabled>"
                    + "</div>"
                    + "</div>"
                    + "<div class=\"form-group\">"
                    + "<label class=\"col-md-3 control-label\">Password:</label>"
                    + "<div class=\"col-md-8\">"
                    + "<input id=\"Password\" class=\"form-control\" type=\"password\" value=\""+password+"\">"
                    + "</div></div>"
                    + "<div class=\"form-group\">"
                    + "<label class=\"col-md-3 control-label\">Interests:</label>"
                    + "<div class=\"col-md-8\">"
                    + "<div class=\"btn-group btn-group\" data-toggle=\"buttons\">"
                    + "<label class=\"btn "+(interests.contains("Sports")? "active": "")+"\">"
                    + "<input class=\"int\" type=\"checkbox\" id=\"sports\" value=\"1\" name='interest' "+(interests.contains("Sports")? "checked": "")+"><i class=\"fa fa-square-o fa-2x\"></i><i class=\"fa fa-check-square-o fa-2x\"></i><span> Sports</span>"
                    + "</label>"
                    + "<label class=\"btn "+(interests.contains("Entertainment")? "active": "")+"\">"
                    + "<input class=\"int\" type=\"checkbox\" id=\"entertainment\" value=\"2\" name='interest' "+(interests.contains("Entertainment")? "checked": "")+"><i class=\"fa fa-square-o fa-2x\"></i><i class=\"fa fa-check-square-o fa-2x\"></i><span> Entertainment</span>"
                    + "</label>"
                    + "<label class=\"btn "+(interests.contains("Politics")? "active": "")+"\">"
                    + "<input class=\"int\" type=\"checkbox\" id=\"politics\" value=\"3\" name='interest' "+(interests.contains("Politics")? "checked": "")+"><i class=\"fa fa-square-o fa-2x\"></i><i class=\"fa fa-check-square-o fa-2x\"></i><span> Politics</span>"
                    + "</label>"
                    + "<label class=\"btn "+(interests.contains("Education")? "active": "")+"\">"
                    + "<input class=\"int\" type=\"checkbox\" id=\"education\" value=\"4\" name='interest' "+(interests.contains("Education")? "checked": "")+"><i class=\"fa fa-square-o fa-2x\"></i><i class=\"fa fa-check-square-o fa-2x\"></i><span> Education </span>"
                    + "</label>"
                    + "<label class=\"btn "+(interests.contains("Technology")? "active": "")+"\">"
                    + "<input class=\"int\" type=\"checkbox\" id=\"technology\" value=\"5\" name='interest' "+(interests.contains("Technology")? "checked": "")+"><i class=\"fa fa-square-o fa-2x\"></i><i class=\"fa fa-check-square-o fa-2x\"></i><span> Technology</span>"
                    + "</label>"
                    + "<label class=\"btn "+(interests.contains("Travel")? "active": "")+"\">"
                    + "<input class=\"int\" type=\"checkbox\" id=\"travel\" value=\"6\" name='interest' "+(interests.contains("Travel")? "checked": "")+"><i class=\"fa fa-square-o fa-2x\"></i><i class=\"fa fa-check-square-o fa-2x\"></i><span> Travel</span>"
                    + "</label>"
                    + "</div></div></div>"
                    + "<div class=\"form-group\">"
                    + "<label class=\"col-md-3 control-label\"></label>"
                    + "<div class=\"col-md-8\">"
                    + "<input id=\"saveUser\" type=\"button\" class=\"btn btn-primary\" value=\"Save Changes\">"
                    + "</div></div></form>";
                    
                    outHTML = formHTML;
                    break;
            }
            
            response.getWriter().print(outHTML);
        }
  }
  catch(Exception e) {
    response.getWriter().println("SQLException caught: " + e.getStackTrace()[0]+"\n ");
  }
%>
