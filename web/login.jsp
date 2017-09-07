<%@page import="java.util.Enumeration"%>
<%@ page session="true" %>
<html>
<head>
    <title>Main page</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/login3.css">
    <link rel="stylesheet" href="css/radio.css">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Amatica+SC:400,700' rel='stylesheet' type='text/css'>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<div class="jumbotron jumbotron-fluid">
    <div class="col-md-7">
<%  
    if(session.getAttribute("user")!= null){
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", "index.jsp");
    }
    else if(application.getAttribute("Response") != null){
        response.getWriter().print("<h3>"+application.getAttribute("Response")+"</h3>");
        application.setAttribute("Response",null);
    }
%>
</div>
    <div id="Quote" class="col-lg-6 col-md-6">
  <div id="sb">ShareBoard</div>
  Where the nation <br> actually gets to know.
  </div>
    <div class="col-md-5" id="loginbox">
            <div class="panel panel-login">
                    <div class="panel-heading">
                            <div class="row">
                                    <div class="col-xs-6">
                                            <a href="#" class="active" id="login-form-link">Login</a>
                                    </div>
                                    <div class="col-xs-6">
                                            <a href="#" id="register-form-link">Register</a>
                                    </div>
                            </div>
                            <hr>
                    </div>
                    <div class="panel-body">
                            <div class="row">
                                    <div class="col-lg-12">
                                            <form id="login-form" action="signin.jsp" method="post" role="form" style="display: block;">
                                                    <div class="form-group">
                                                        
                                                            <input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Username" value="">
                                                    </div>
                                                    <div class="form-group">
                                                            <input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Password">
                                                    </div>
                                                    <div class="form-group">
                                                            <div class="row">
                                                                    <div class="col-sm-6 col-sm-offset-3">
                                                                            <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Log In">
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </form>
                                            <form id="register-form" action="signupVerify.jsp" method="post" role="form" style="display: none;">
                                                <input type="hidden" id="page" name="page" value="login">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                        <span class="input-group-addon glyphicon glyphicon-user"></span>
                                                            <input type="text" name="fullname" id="fullname" tabindex="1" class="form-control" placeholder="Full Name" value="" required>
                                                    
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                        <span class="input-group-addon glyphicon glyphicon-eye-open"></span>
                                                            <input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Username" value="" required>
                                                    
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                        <span class="input-group-addon">@</span>
                                                            <input type="email" name="email" id="email" tabindex="1" class="form-control" placeholder="Email Address" value="" required>
                                                    
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                        <span class="input-group-addon glyphicon glyphicon-calendar"></span>
                                                            <input type="text" name="dob" id="dob" tabindex="1" class="form-control" placeholder="DD-MM-YYYY" value="" required>
                                                    
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                        <span class="input-group-addon glyphicon glyphicon-lock"></span>
                                                            <input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Password" required>
                                                    
                                                        </div>
                                                    </div>
                                                <div class="row">
                                                        <div class="col-xs-12">
                                                            
                                                          <div class="btn-group" data-toggle="buttons">
                                                              <h4>Gender:</h4>
                                                            <label class="btn active">
                                                              <input type="radio" name='gender' value="M" checked><i class="fa fa-check-circle-o fa-2x"></i><span> Male</span>
                                                            </label>
                                                            <label class="btn">
                                                                <input type="radio" name='gender' value="F"><i class="fa fa-check-circle-o fa-2x"></i><span> Female</span>
                                                            </label>
                                                          </div>


                                                        </div>
                                                      </div>
                                                      <h4>Interests:</h4>

                                                      <div class="btn-group btn-group" data-toggle="buttons">
                                                        <label class="btn">
                                                            <input type="checkbox" id="sports" value="1" name='interest'><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i><span> Sports</span>
                                                        </label>
                                                        <label class="btn">
                                                            <input type="checkbox" id="entertainment" value="2" name='interest'><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i><span> Entertainment</span>
                                                        </label>
                                                        <label class="btn">
                                                            <input type="checkbox" id="politics" value="3" name='interest'><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i><span> Politics</span>
                                                        </label>
                                                          <label class="btn">
                                                              <input type="checkbox" id="education" value="4" name='interest'><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i><span> Education </span>
                                                        </label>
                                                        <label class="btn">
                                                            <input type="checkbox" id="technology" value="5" name='interest'><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i><span> Technology</span>
                                                        </label>
                                                        <label class="btn">
                                                            <input type="checkbox" id="travel" value="6" name='interest'><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i><span> Travel</span>
                                                        </label>
                                                      </div>
                                                      <br><br>
                                                    <div class="form-group">
                                                            <div class="row">
                                                                    <div class="col-sm-6 col-sm-offset-3">
                                                                            <input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="Register Now">
                                                                    </div>
                                                            </div>
                                                    </div>
                                            </form>
                                    </div>
                            </div>
                    </div>
            </div>
    </div>
</div>
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/FB.js"></script>
</body>
</html>