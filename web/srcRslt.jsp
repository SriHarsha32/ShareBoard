<html>
<head>
    <title>Main page</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/newFB.css">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Amatica+SC:400,700' rel='stylesheet' type='text/css'>
  </head>
</head>
<body>
    <%
            //if(session.getAttribute("user")== null){
                //response.setStatus(response.SC_MOVED_TEMPORARILY);
                //response.setHeader("Location", "login.jsp");
            //}
        %>
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
	<div class="text-center" style="padding-top:70px; margin: 0 auto; max-width: 1000px;" >
            <div class="panel panel-primary text-center">
                <div class="panel-body">
                    <div class="input-group input-group-sm">
                        <input id="SQL" type="text" class="form-control" placeholder="SQL Query">
                        <div class="input-group-btn">
                            <button id="dosql" class="btn btn-default"><i class="glyphicon glyphicon-search"></i></button>
                        </div>
                    </div>
                    <div id="res" style="margin-top:50px;">
                        
                    </div>
                </div>
            </div>
        </div>
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#dosql").on("click",function(){
            var sql = $("#SQL").val();
            $.ajax({
                type : "POST",
                url : "getContent.jsp",
                data : "query="+sql,
                success : function(data) {
                    $("#res").html(data);
                }
            });
        });
    });
</script>
</body>
</html>
