<%@page import="SbUtils.URLGetter"%>
<%@page import="SbUtils.Changer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
  String srch = request.getParameter("srch");
  String topic = request.getParameter("topic");
    try{
        Statement stmt = null;
        String getShareSQL = "";
        String shareHTML= "";
        if(topic.equals("xnull") && srch.equals("xnull")){
            
            Statement stmtx = dbConn.createStatement();
            ResultSet intids = stmtx.executeQuery("SELECT tid FROM `typesconfig` WHERE username='"+user+"'");
            String ints="";
            while(intids.next()){
                ints += intids.getInt("tid");
                if(!intids.isLast())
                    ints += ",";
            }
            
            
            if(ints.equals(""))
                getShareSQL = "SELECT * FROM shares S,userdetails U WHERE S.username=U.username ORDER BY SharedOn DESC";
            else{
                getShareSQL = "SELECT * FROM shares S,userdetails U WHERE S.username=U.username AND SType IN ("+ints+") ORDER BY SharedOn DESC";
                stmtx = dbConn.createStatement();
                intids = stmtx.executeQuery("SELECT tname FROM `types` WHERE tid IN ("+ints+")");
                ints="";
                while(intids.next()){
                    ints += intids.getString("tname");
                    if(!intids.isLast())
                        ints += ",";
                }
            }
            shareHTML = "<div id=\"tempAlert\" class=\"panel panel-info\">" +
                          "<div class=\"panel-body\">Showing posts from <strong>"+ints+"</strong></div>" +
                          "</div>";
            response.getWriter().print(shareHTML);
        }
        else if(topic.equals("xnull") && !srch.equals("xnull")){
            boolean isUnion = true;
            boolean isSingle = true;
            if(srch.contains(",") || srch.contains("/"))
                isSingle = false;
            if(isSingle){
                srch = srch.substring(1);
                String getSIDSQL = "SELECT ShareId FROM shares WHERE ShareId IN (SELECT Shareid FROM hashshares WHERE hashid=(SELECT hashid FROM hashtag WHERE hashName='"+srch.trim()+"'))";
                Statement stmt2 = dbConn.createStatement();
                ResultSet shareids = stmt2.executeQuery(getSIDSQL);
                String get="";
                while(shareids.next()){
                    get += "(SELECT * FROM shares S,userdetails U WHERE (S.username=U.username AND S.ShareId="+shareids.getInt("ShareId")+") ORDER BY SharedOn DESC)";
                    if(!shareids.isLast())
                        get += " UNION ";
                }
                getShareSQL += get;
            }
            else{
                String srctrms[] = srch.split(",");
                List<String> getStrings = new ArrayList<>(); 
                for(int i=0;i<srctrms.length;i++){
                    srctrms[i] = srctrms[i].trim().substring(1);
                    String getSIDSQL = "SELECT ShareId FROM shares WHERE ShareId IN (SELECT Shareid FROM hashshares WHERE hashid=(SELECT hashid FROM hashtag WHERE hashName='"+srctrms[i]+"'))";
                    Statement stmt2 = dbConn.createStatement();
                    ResultSet shareids = stmt2.executeQuery(getSIDSQL);
                    String get="";
                    while(shareids.next()){
                        get += "(SELECT * FROM shares S,userdetails U WHERE (S.username=U.username AND S.ShareId="+shareids.getInt("ShareId")+") ORDER BY SharedOn DESC)";
                        if(!shareids.isLast())
                            get += " UNION ";
                    }
                    if(!get.equals("")){
                        getStrings.add(get);
                    }
                }
                for(int x=0;x<getStrings.size();x++)
                {
                    getShareSQL += getStrings.get(x);
                    if(x != getStrings.size() - 1)
                        getShareSQL += " UNION ";
                }

            }
        }
        else if(!topic.equals("xnull") && srch.equals("xnull")){
            getShareSQL = "SELECT * FROM shares S,userdetails U WHERE (S.username=U.username AND S.SType="+Integer.parseInt(topic)+") ORDER BY SharedOn DESC";
            Statement stmtx = dbConn.createStatement();
            ResultSet intids = stmtx.executeQuery("SELECT tname FROM `types` WHERE tid ="+Integer.parseInt(topic)+"");
            String ints="";
            if(intids.next()){
                ints = intids.getString("tname");
            }
            shareHTML = "<div id=\"tempAlert\" class=\"panel panel-info\">" +
                          "<div class=\"panel-body\">Showing posts from <strong>"+ints+"</strong></div>" +
                          "</div>";
            response.getWriter().print(shareHTML);
        }
        stmt = dbConn.createStatement();
        
        if(getShareSQL.equals("")){
            shareHTML = "<div id=\"tempAlert\" class=\"alert alert-danger\">" +
                          "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                          "<strong>ALERT!</strong> No shares avialable for speicified constraint." +
                          "</div>";
            response.getWriter().print(shareHTML);
            return;
        }
        ResultSet shares = stmt.executeQuery(getShareSQL);
        boolean foundShares = false;
        while(shares.next()){
            foundShares = true;
            String fullname = shares.getString("fullname");
            String shareUser = shares.getString("username");
            String STitle = shares.getString("STitle");
            String SBody = shares.getString("SBody");
            int type = shares.getInt("SType");
            String date = shares.getString("SharedOn");
            int Sid = shares.getInt("ShareId");
            String link  = shares.getString("SLink");
            if(shares.wasNull())
                link = "";
            String category="";
            switch(type){
                case 1: category="sports";break;
                case 2: category="entertainment";break;
                case 3: category="politics";break;
                case 4: category="education";break;
                case 5: category="technology";break;
                case 6: category="travel";break;
            }
            
            Statement stmt2 = null;
            String getHashesSQL = "SELECT hashName FROM hashtag WHERE hashid IN (SELECT hashid FROM hashshares WHERE Shareid="+Sid+")";
            stmt2 = dbConn.createStatement();
            ResultSet hashIds = stmt2.executeQuery(getHashesSQL);
            String[] hashes = new String[5];
            int i=0;
            while(hashIds.next()){
                hashes[i++] = hashIds.getString("hashName");
            }
            
            Statement stmt3 = null;
            String reactHTML = "";
            String getReactSQL = "SELECT RType FROM reactions WHERE Sid="+Sid+" AND username='"+user+"'";
            stmt3 = dbConn.createStatement();
            ResultSet react = stmt3.executeQuery(getReactSQL);
            if(react.next()){
                // has reactions
                String re = react.getString("RType");
                reactHTML += "<span class=\"like-btn-emo like-btn-"+re.toLowerCase()+"\"></span>"
                    + "<span class=\"like-btn-text like-btn-text-"+re.toLowerCase()+" active\">"+re+"</span>";
            }
            else{
                // no reactions
                reactHTML += "<span class=\"fa like-btn-emo fa-thumbs-o-up\"></span>"
                    + "<span class=\"like-btn-text\">Like</span>";
            }
            
            String getUser = "SELECT username,email FROM usermindets WHERE fullname='"+fullname+"'";
            Statement vwstmt = dbConn.createStatement();
            ResultSet vw = vwstmt.executeQuery(getUser);
            String email="",username="";
            if(vw.next()){
                email = vw.getString("email");
                username = vw.getString("username");
            }
            
            // call procedures 
            String getCmntCnt = "{call getUserCmnts (?, ?)}";
            CallableStatement cst = dbConn.prepareCall(getCmntCnt);
            cst.setString(1, user);
            cst.registerOutParameter(2, java.sql.Types.INTEGER);
            cst.execute();
            String cmntsCnt = ("Comments:<strong>"+cst.getInt(2)+"</strong>");
            
            String getReactsCnt = "{call getUserReacts (?, ?)}";
            cst = dbConn.prepareCall(getReactsCnt);
            cst.setString(1, user);
            cst.registerOutParameter(2, java.sql.Types.INTEGER);
            cst.execute();
            String reactsCnt = ("Reactions:<strong>"+cst.getInt(2)+"</strong>");
            
            String getShares = "{call getUserShares (?, ?)}";
            cst = dbConn.prepareCall(getShares);
            cst.setString(1, user);
            cst.registerOutParameter(2, java.sql.Types.INTEGER);
            cst.execute();
            String sharesCnt = ("Shares:<strong>"+cst.getInt(2)+"</strong>");
            
            
            String color = RandomColor.getColor();
            
            shareHTML ="<div id=\"share"+Sid+"\" class=\"panel panel-default shareMain\"><div class=\"panel-body\">" 
                    +"<div class=\"panel panel-default\" style=\"margin:0px; padding:0px;\">" 
                    +"<div class=\"panel-heading\">"
                    +"<section class=\"post-heading\">"
                    +"<div class=\"row\">"
                    +"<div class=\"col-md-12\">"
                    +"<div class=\"media\">"
                    + "<div class=\"media-left\">"
                    //+"<a href=\"#\">"
                    +"<div class=\"circle\" style=\""+color+";\">"+fullname.charAt(0)+"</div>"
                    //+"</a>"
                    +"</div><div class=\"media-body\">"
                    + "<a href=\"#\" class=\"anchor-username tip_trigger\">"
                    + "<h4 class=\"media-heading\">"+fullname+"</h4>"
                    + "<span class=\"tip\" style=\"width: 400px;\">"
                    + "<div class=\"col-sm-2\">"
                    + "<div class=\"circle\" style=\""+color+";\">"+fullname.charAt(0)+"</div>"
                    + "</div>"
                    + "<div class=\"col-sm-10\" style=\"float: right;\">"
                    + fullname+"<br>"+username+"<br>"+email+"<br>"+sharesCnt+" | "+cmntsCnt+" | "+reactsCnt
                    + "</div>"
                    + "</span>"
                    + "</a>"
                    + Changer.ChangeDate(date,"yyyy-MM-dd","dd-MM-yyyy")
                    + "</div>";
                    //insert media-right
            if(user.equals(shareUser)){
                shareHTML += "<div class=\"media-right delShare\">"
                               +"<button type=\"button\" class=\"close\">x</button>"
                             +"</div>";
            }
            
            shareHTML += "</div></div></div></section></div>"
                    + "<div class=\"post-color "+category+"\"></div>"
                    + "<div class=\"panel-body\" style=\"margin-top:5px; padding:10px;\">"
                    + "<section class=\"post-body\">"
                    + "<h4>"+STitle+"</h4>"
                    + "<p>"+SBody+"</p><hr>";
            
            //get reaction count and comment count
            String getCmnt = "{call getIndCmntCount (?, ?)}";
            cst = dbConn.prepareCall(getCmnt);
            
            cst.setInt(1, Sid);
            cst.registerOutParameter(2, java.sql.Types.INTEGER);
            cst.execute();
            
            shareHTML += ("Comments: <strong>"+cst.getInt(2)+"</strong>");
            
            String getReacts = "{call getIndReactCount (?, ?)}";
            cst = dbConn.prepareCall(getReacts);
            cst.setInt(1, Sid);
            cst.registerOutParameter(2, java.sql.Types.INTEGER);
            cst.execute();
            
            shareHTML += ("<span style=\"margin-left:20px;\"></span>Reactions: <strong>"+cst.getInt(2)+"</strong><br>");
            
            String hashtags = "";
            boolean ishashpresent = false;
            for(int j=0;j<5;j++){
                if(hashes[j]!=null && !hashes[j].equals("")){
                    hashtags += "<a>#"+hashes[j]+"</a> ";
                    ishashpresent = true;
                }
            }
            if(ishashpresent)
                shareHTML += hashtags;
            if(!link.equals(""))
                shareHTML += "<a href=\""+link+"\" target=\"_blank\"><button class=\"btn btn-sm btn-default text-left\" type=\"button\" style=\"width:100%; margin:5px;\">"
                        + "<i class=\"glyphicon glyphicon-upload\"></i>  "+link+"</button></a>";
            
            
            
            shareHTML += "</section></div>"
                    + "<hr style=\"margin:0px;\"><section class=\"post-footer\">"
                    + "<div class=\"post-footer-option container\">"
                    + "<ul class=\"list-unstyled reacts\">"
                    + "<li>"
                    + "<div class=\"facebook-reaction\">"
                    + "<span class=\"like-btn\"> <!-- Default like button --> ";
            shareHTML += reactHTML;
            shareHTML += "<ul class=\"reactions-box\">"
                    + "<!-- Reaction buttons container-->"
                    + "<li class=\"reaction reaction-like\" data-reaction=\"Like\"></li>"
                    + "<li class=\"reaction reaction-love\" data-reaction=\"Love\"></li>"
                    + "<li class=\"reaction reaction-haha\" data-reaction=\"HaHa\"></li>"
                    + "<li class=\"reaction reaction-wow\" data-reaction=\"Wow\"></li>"
                    + "<li class=\"reaction reaction-sad\" data-reaction=\"Sad\"></li>"
                    + "<li class=\"reaction reaction-angry\" data-reaction=\"Angry\"></li>"
                    + "<li class=\"reaction reaction-cancel\" data-reaction=\"Cancel\"></li>"
                    + "</ul>"
                    + "</span>"
                    + "</div></li>"
                    + "<li><a href=\"#\" class=\"cmnt1\"><i class=\"glyphicon glyphicon-comment\"></i> Comment</a></li>"
                    + "<li><a href=\"#\" class=\"viewAll\"><i class=\"glyphicon glyphicon-list-alt\"></i> View all</a></li>"
                    + "</ul></div>"
                    +"<div class=\"message\" id=\"cmntp\" style=\"display:none;\">"
                    + "<hr>"
                    + "<div class=\"input-group text-center\">"
                    + "<input id=\"cmtBox"+Sid+"\" type=\"text\" class=\"form-control input-sm\" placeholder=\"Add a comment. . .\"></input>"
                    + "<span class=\"input-group-btn\"><button class=\"btn btn-sm btn-primary cmntSbmt\" type=\"button\"><i class=\"glyphicon glyphicon-check\"></i> OK</button></span>"
                    + "</div></div></section></div></div></div>";
            response.getWriter().print(shareHTML);
        }
        if(!foundShares){
            shareHTML = "<div id=\"tempAlert\" class=\"alert alert-danger\">" +
                          "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                          "<strong>ALERT!</strong> No shares avialable for speicified constraint." +
                          "</div>";
            response.getWriter().print(shareHTML);
        }
        
  }
  catch(Exception e) {
      String stk = "";
      for(StackTraceElement stee : e.getStackTrace()){
          stk += (stee.toString() + "\n");
      }
    response.getWriter().println("SQLException caught: " +stk+"\n ");
    response.getWriter().println("MEssage:"+e.getLocalizedMessage()+"\n");
  }
%>