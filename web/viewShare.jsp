<html>
<head>
    <title>Main page</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/newFB.css">
    <link rel="stylesheet" href="css/FBr.css">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Amatica+SC:400,700' rel='stylesheet' type='text/css'>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
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
                    <div class="col-md-3 extra"></div>
                    <div id="res" class="col-md-6">
                        
                    </div>
                    <div class="col-md-3 extra"></div>
                </div>
            </div>
        </div>
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var params={};
        window.location.search
          .replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str,key,value) {
            params[key] = value;
          }
        );
        $.ajax({
            type : "POST",
            url : "getFullShare.jsp",
            data : "Shareid="+params['sid'],
            success : function(data) {
                $("#res").html(data);
                $(".reaction").on("click",react);
                $('.cmnt1').click(cmt); 
                $(".cmntSbmt").on("click",cmtsb);
                $(".tip_trigger").hover(function () {
                    tip = $(this).find('.tip');
                    tip.show(); //Show tooltip
                }, function () {
                    tip.hide(); //Hide tooltip		  
                }).mousemove(function (e) {

                });
            }
        });
    });
    
    var react = function(){   // like click
                var data_reaction = $(this).attr("data-reaction");
                var shareid = $(this).parents(".shareMain").attr("id");
                if(data_reaction === "Cancel"){
                    if($(this).parent().siblings(".like-btn-text").hasClass("active")){
                          $(this).parent().siblings(".like-btn-text").text("Like").removeClass().addClass('like-btn-text');
                          $(this).parent().siblings(".like-btn-emo").removeClass().addClass('like-btn-emo').addClass("like-btn-default");
                          $.ajax({
                              type : "POST",
                              url : "ReactDB.jsp",
                              data : "action=deleteReact&ShareId="+shareid,
                              success : function(data) {
                                  $("#res").prepend(data);
                              }
                          }); 
                    }
                }
                else{
                        $(this).parent().siblings(".like-btn-emo").removeClass().addClass('like-btn-emo').addClass('like-btn-'+data_reaction.toLowerCase());
                        $(this).parent().siblings(".like-btn-text").text(data_reaction).removeClass().addClass('like-btn-text').addClass('like-btn-text-'+data_reaction.toLowerCase()).addClass("active");
                        $.ajax({
                            type : "POST",
                            url : "ReactDB.jsp",
                            data : "action=updateReact&ShareId="+shareid+"&RType="+data_reaction,
                            success : function(data) {
                                $("#res").prepend(data);
                                $(".like-btn-text").on("click",function(){ // undo like click
                                        if($(this).hasClass("active")){
                                              $(this).text("Like").removeClass().addClass('like-btn-text');
                                              $(this).siblings(".like-btn-emo").removeClass().addClass('like-btn-emo').addClass("like-btn-default");
                                              $.ajax({
                                                  type : "POST",
                                                  url : "ReactDB.jsp",
                                                  data : "action=deleteReact&ShareId="+shareid,
                                                  success : function(data) {
                                                      $("#res").prepend(data);
                                                  }
                                              }); 
                                        }	  
                                }); 
                            }
                        }); 
                    }
                };
    var cmt = function(){	
                var parentDiv = $(this).parents(".post-footer-option");
                var commentForm = parentDiv.siblings("#cmntp");
                if(commentForm.hasClass("visible")){
                    commentForm.css({'display':'none',transition : 'all 1s ease-in-out'});
                    commentForm.removeClass("visible");
                }
                else{
                    commentForm.css('display','block');
                    commentForm.addClass("visible");
                }
            };
    var cmtsb = function(){ // comment ok click
                var divParent = $(this).parents("#cmntp");
                var shareid = $(this).parents(".shareMain").attr("id");
                var comment = $("#cmtBox"+shareid.substring(5)).val();
                $.ajax({
                    type : "POST",
                    url : "addComment.jsp",
                    data : "Comment="+comment+"&ShareId="+shareid,
                    success : function(data) {
                        $("#res").prepend(data);
                    }
                });
                if(divParent.hasClass("visible")){
                    divParent.css({'display':'none',transition : 'all 1s ease-in-out'});
                    divParent.removeClass("visible");
                }
            };
</script>
</body>
</html>
