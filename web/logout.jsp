<%-- 
    Document   : logout
    Created on : Nov 7, 2016, 9:28:47 PM
    Author     : SriGanesha
--%>
<%@page import="java.util.Enumeration"%>
<%@ page session="true" %>
<%!
        String resultString = "Logged out successfully.";
        boolean success = false;
%>
<html>
    <body>
        <%
            session.removeAttribute("user");
            session.invalidate();
            application.setAttribute("Response", resultString);
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", "login.jsp"); 
          %>
    </body>
</html>

