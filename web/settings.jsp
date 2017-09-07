<html>
<head>
    <title>Main page</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/newFB.css">
    <link rel="stylesheet" href="css/radio.css">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Amatica+SC:400,700' rel='stylesheet' type='text/css'>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
  </head>
</head>
<body>
<div class="navbar navbar-blue navbar-static-top">
		<div id="navi">
			<div class="navbar-header">
				<button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a href="/" class="navbar-brand logo">SB</a>
				<a class="navbar-brand" id="Brandname" href="index.jsp">ShareBoard</a>
			</div>
			<nav class="collapse navbar-collapse" role="navigation">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="account.jsp"><span class="glyphicon glyphicon-user"></span> Account</a></li>
					<li><a href="settings.jsp"><span class="glyphicon glyphicon-cog"></span> Settings</a></li>
					<li><a href="logout.jsp"><span class="glyphicon glyphicon-off"></span> Logout</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<div id="accinfo">
	<div class = "panel panel-primary">
   <div class = "panel-heading">
      <h1 class = "panel-title">Edit Profile</h1>
   </div>
   <div class = "panel-body">
	<div class="row">
      <!-- left column -->
      <div class="col-md-3">
        <div class="text-center">
          <img src="//placehold.it/100" class="avatar img-circle" alt="avatar">
        </div>
      </div>
      
      <!-- edit form column -->
      <div id="accform" class="col-md-9 personal-info">
        <div class="alert alert-info alert-dismissable">
          <a class="panel-close close" data-dismiss="alert">x</a> 
          <i class="fa fa-coffee"></i>
          Please <strong>save</strong> changes after editing information.
        </div>
        <h3>Personal info</h3>
      </div>
  </div>
  
</div>
</div>
	</div>
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $.ajax({
            type : "POST",
            url : "getUser.jsp",
            data : "page=settings",
            success : function(data) {
                $("#accform").append(data);
                $("#saveUser").on("click",null);
                $("#saveUser").on("click",submit);
            }
        });
    });
    
    var submit = function(){
        fullname = $("#FullName").val();
        gender = $("#gender>option:selected").val();
        email = $("#email").val();
        dob = $("#dob").val();
        username = $("#UserName").val();
        pass = $("#Password").val();
        var checkedVals = $('.int:checkbox:checked').map(function() {
            return this.value;
        }).get();
        interests = checkedVals.join(",");
        $.ajax({
            type : "POST",
            url : "signupVerify.jsp",
            data : "page=settings&fullname="+fullname+"&username="+username+"&email="+email+"&gender="+gender+"&dob="+dob+"&interests="+interests+"&password="+pass,
            success : function(data) {
                
                newCont = "<div id=\"tempAlert\" class=\"alert alert-info\">" +
                          "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                          data +
                          "</div>";
                $("#accform").append(newCont);
            }
        });
    };
</script>
</body>
</html>