<%-- 
    Document   : index2
    Created on : Nov 7, 2016, 10:26:26 PM
    Author     : SriGanesha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            if(session.getAttribute("user")== null){
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "login.jsp");
            }
        %>
	<div class="wrapper">
		<div class="box">
			<!-- top nav -->
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
						<div class="navbar-form navbar-left" >
							<div class="input-group input-group-sm" style="min-width:300px; max-width:500px;">
								<input id="SRCH" type="text" class="form-control" placeholder="Search">
								<div class="input-group-btn">
                                                                    <button id="dosrc" class="btn btn-default"><i class="glyphicon glyphicon-search"></i></button>
								</div>
							</div>
						</div>
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#postModal" role="button" data-toggle="modal"><i class="glyphicon glyphicon-plus"></i> Post</a></li>
							<li><a href="account.jsp"><span class="glyphicon glyphicon-user"></span> Account</a></li>
							<li><a href="settings.jsp"><span class="glyphicon glyphicon-cog"></span> Settings</a></li>
							<li><a href="logout.jsp"><span class="glyphicon glyphicon-off"></span> Logout</a></li>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /top nav -->
			<div class="row row-offcanvas row-offcanvas-left">
				<!-- sidebar -->
				<div class="column col-sm-2 col-xs-1 sidebar-offcanvas" id="sidebar">
					<ul class="nav">
						<li><a href="#" data-toggle="offcanvas" class="visible-xs text-center"><i class="glyphicon glyphicon-chevron-right"></i></a></li>
					</ul>
					<ul class="nav hidden-xs" id="lg-menu">
                                            <li class="active"><div class="navrow" id="topic1"><i class="glyphicon  topic-circle sports"><img src="images/sports.png" width="15" height="15"></i> Sports</div></li>
                                            <li><div class="navrow" id="topic2"><i class="glyphicon  topic-circle entertainment"><img src="images/entertainment.png" width="15" height="15"></i> Entertainment</div></li>
						<li><div class="navrow" id="topic3"><i class="glyphicon  topic-circle politics"><img src="images/politics.png" width="15" height="15"></i> Politics</div></li>
						<li><div class="navrow" id="topic4"><i class="glyphicon  topic-circle educational"><img src="images/education.png" width="15" height="15"></i> Education</div></li>
						<li><div class="navrow" id="topic5"><i class="glyphicon  topic-circle technology"><img src="images/technology.png" width="15" height="15"></i> Technology</div></li>
						<li><div class="navrow" id="topic6"><i class="glyphicon  topic-circle travel"><img src="images/travel.png" width="15" height="15"></i> Travel</div></li>
					</ul>
					<!-- tiny only nav-->
					<ul class="nav visible-xs" id="xs-menu">
						<li><a href="" class="text-center"><i class="glyphicon glyphicon-list-alt"></i></a></li>
						<li><a href="" class="text-center"><i class="glyphicon glyphicon-list"></i></a></li>
						<li><a href="" class="text-center"><i class="glyphicon glyphicon-paperclip"></i></a></li>
						<li><a href="" class="text-center"><i class="glyphicon glyphicon-refresh"></i></a></li>
					</ul>
				</div>
				<!-- /sidebar -->
				
				<!-- main -->
				<div class="column col-sm-7 col-xs-11" id="main">
                <div class="padding">
                    <div class="full col-sm-9">
                        <!-- content -->                      
                      	<div class="row">
						<div id="postscontainer" class="col-md-12 col-sm-12 col-xs-12">
						  <div class="panel panel-default shareMain" id="share18">
                                                        <div class="panel-body">
                                                            <div class="panel panel-default" style="margin:0px; padding:0px;">
                                                                <div class="panel-heading">
                                                                    <section class="post-heading">
                                                                        <div class="row">
                                                                            <div class="col-md-12">
                                                                                <div class="media">
                                                                                    <div class="media-left">
                                                                                        <a href="#">
                                                                                            <div class="circle">SS</div>
                                                                                        </a>
                                                                                    </div>
                                                                                    <div class="media-body">
                                                                                            <a href="#" class="anchor-username tip_trigger"><h4 class="media-heading">SriHarsha Sreenath</h4>
                                                                                            <span class="tip" style="width: 400px;">
                                                                                                <div class="col-sm-2">
                                                                                                    <div class="circle">SS</div>
                                                                                                </div>
                                                                                                <div class="col-sm-10" style="float: right;">
                                                                                                    SriHarsha Sreenath<br>sriharsha.s32@gmail.com<br>
                                                                                                </div>
                                                                                            </span>
                                                                                            </a>
                                                                                            <a href="#" class="anchor-time">02-Nov-2016 8:10 PM</a>
                                                                                    </div>
                                                                                    <div class="media-right">
                                                                                        <button type="button" class="close">x</button>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>             
                                                                    </section>
                                                                </div>
                                                                <div class="post-color sports"></div>
                                                                <div class="panel-body" style="margin-top:5px; padding:10px;">
                                                                    <section class="post-body">
                                                                        <h4>The post header</h4>
                                                                            <p>This is a post related to sports</p>
                                                                            <button class="btn btn-sm btn-default text-left" type="button" style="width:100%;"><i class="glyphicon glyphicon-upload"></i> Goto the website (This is a dummy link)</button>
                                                                    </section>
                                                                </div>
                                                                <hr style="margin:0px;">
                                                                <section class="post-footer">
                                                                        <!--<div class="panel panel-default" style="margin:0px; padding:10px;">-->
                                                                    <div class="post-footer-option container">
                                                                        <ul class="list-unstyled reacts">
                                                                            <li>
                                                                                <div class="facebook-reaction">
                                                                                    <span class="like-btn"> <!-- Default like button --> 
                                                                                        <span class="fa like-btn-emo fa-thumbs-o-up"></span> <!-- Default like button emotion--> 
                                                                                        <span class="like-btn-text">Like</span> <!-- Default like button text,(Like, wow, sad..) default:Like  -->
                                                                                        <ul class="reactions-box">
                                                                                          <!-- Reaction buttons container-->
                                                                                          <li class="reaction reaction-like" data-reaction="Like"></li>
                                                                                          <li class="reaction reaction-love" data-reaction="Love"></li>
                                                                                          <li class="reaction reaction-haha" data-reaction="HaHa"></li>
                                                                                          <li class="reaction reaction-wow" data-reaction="Wow"></li>
                                                                                          <li class="reaction reaction-sad" data-reaction="Sad"></li>
                                                                                          <li class="reaction reaction-angry" data-reaction="Angry"></li>
                                                                                          <li class="reaction reaction-cancel" data-reaction="Cancel"></li>
                                                                                        </ul>
                                                                                    </span>
                                                                                </div>
                                                                            </li>
                                                                                <li><a href="#" class="cmnt1"><i class="glyphicon glyphicon-comment"></i> Comment</a></li>
                                                                                <li><a href="#" class="viewAll"><i class="glyphicon glyphicon-list-alt"></i> View all</a></li>
                                                                        </ul>
                                                                    </div>
                                                                        <div class="message visible" id="cmntp">
                                                                           <hr>
                                                                           <div class="input-group text-center">
                                                                                <input type="text" class="form-control input-sm" placeholder="Add a comment. . .">
                                                                                <span class="input-group-btn"><button class="btn btn-sm btn-primary" type="button"><i class="glyphicon glyphicon-check"></i> OK</button></span>
                                                                            </div>
                                                                        </div>
                                                                        <!--</div>-->
                                                                </section>
                                                            </div>
							</div>   
                                                    </div>
                                                </div>

					
					</div>
					</div>
				</div>
				</div>
				<!-- right sidebar -->
			<div id="rightPanel" class="column col-sm-3" style="padding:0px;">
                            <div id="detsHolder">
                            </div>
                            <div id="notifholder" class="full" style="padding:0px; max-height: 400px; overflow: auto;">
                                <div class="panel panel-default">
                                    <div id="notifPanel" class="panel-body">

                                    </div>
                                </div>
                            </div>
                        </div>
				<!-- / right sidebar -->
			</div>
		</div>
	</div>
			<!--post modal-->
<div id="postModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
			New Share
		</div>
		<div class="modal-body">
			<form class="form center-block">
				<div class="form-group">
					<input id="shareTtl" type="text" class="form-control input-sm" placeholder="Share Title">
					<br>
					<textarea id="shareBdy" type="text" class="form-control input-sm" placeholder="What do you want to share?" style="height: 150px;"></textarea>
                                        <br>
                                        <input id="shareLink" type="text" class="form-control input-sm" placeholder="Place link here">
				</div>
			</form>
			<div class="text-center">
				<div class="col-sm-6">
					<label for="hash">Hashtags:</label>
					<div class="form-group input_fields_wrap">
						<div class="input-group input-group-sm" style="min-width:250px; max-width:500px; padding: 5px 0;">
							<div class="input-group-btn">
								<div class="btn btn-default">#</div>
							</div>
							<input type="text" class="form-control" placeholder="Hashtag" name="hash1" id="hash1">
							<div class="input-group-btn">
								<button class="btn btn-default add_field" type="submit"><i class="glyphicon glyphicon-plus"></i></button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group">
					  <label for="catgry">Select Category:</label>
					  <select class="form-control" id="catgry">
						<option>Sports</option>
						<option>Entertainment</option>
						<option>Politics</option>
						<option>Education</option>
						<option>Technology</option>
						<option>Travel</option>
					  </select>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<div>
                            <button id="postShare" class="btn btn-primary btn-sm" data-dismiss="modal" aria-hidden="true">Post</button>
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
        url : "getShares.jsp",
        data : "topic=xnull&srch=xnull",
        success : function(data) {
            $("#postscontainer").prepend(data);
            $(".reaction").on("click",react);
            $('.cmnt1').click(cmt);
            $(".like-btn-text").on("click",lkcncl); 
            $(".cmntSbmt").on("click",cmtsb);
            $('.viewAll').click(view);
            $(".tip_trigger").hover(function () {
                    tip = $(this).find('.tip');
                    tip.show(); //Show tooltip
                }, function () {
                    tip.hide(); //Hide tooltip		  
                }).mousemove(function (e) {

                });
            $(".delShare").click(delPost);
            getNtfs();
        }
    });
    
    var getNtfs = function(){
        $.ajax({
            type : "POST",
            url : "getNotifs.jsp",
            data : "type=notifs",
            success : function(data) {
                $("#notifPanel").html(data);
            }
        });
        $.ajax({
            type : "POST",
            url : "getNotifs.jsp",
            data : "type=reports",
            success : function(data) {
                $("#detsHolder").prepend(data);
            }
        });
    };
    
    var delPost = function(){
        var shareid = $(this).parents(".shareMain").attr("id");
        if(confirm("Are you sure to delete this post ?")){
            $.ajax({
                type : "POST",
                url : "ReactDB.jsp",
                data : "action=deletePost&ShareId="+shareid,
                success : function(data) {
                    newCont = "<div id=\"tempAlert\" class=\"alert alert-success\">" +
                          "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                          "<strong>Success!</strong>" + data +
                          "</div>";
                    $("#postscontainer").prepend(newCont);
                    location.reload();
                }
            });
        }
    };
    
    $("#dosrc").on("click",function(e){
        e.preventDefault();
        var src = $("#SRCH").val();
        $.ajax({
            type : "POST",
            url : "getShares.jsp",
            data : "topic=xnull&srch="+src,
            success : function(data) {
                $("#postscontainer").html(data);
                $(".reaction").on("click",react);
                $('.cmnt1').click(cmt);
                $(".like-btn-text").on("click",lkcncl); 
                $(".cmntSbmt").on("click",cmtsb);
                $('.viewAll').click(view);
                $(".tip_trigger").hover(function () {
                    tip = $(this).find('.tip');
                    tip.show(); //Show tooltip
                }, function () {
                    tip.hide(); //Hide tooltip		  
                }).mousemove(function (e) {

                });
                $(".delShare").click(delPost);
            }
        });
    });
    
    $(".navrow").on("click",function(){
        var topic = $(this).attr("id").substring(5);
        $(".navrow").removeClass("nv-active");
        $(this).addClass("nv-active");
        $.ajax({
            type : "POST",
            url : "getShares.jsp",
            data : "topic="+topic+"&srch=xnull",
            success : function(data) {
                $("#postscontainer").html(data);
                $(".reaction").on("click",react);
                $('.cmnt1').click(cmt);
                $(".like-btn-text").on("click",lkcncl); 
                $(".cmntSbmt").on("click",cmtsb);
                $('.viewAll').click(view);
                $(".tip_trigger").hover(function () {
                    tip = $(this).find('.tip');
                    tip.show(); //Show tooltip
                }, function () {
                    tip.hide(); //Hide tooltip		  
                }).mousemove(function (e) {

                });
                $(".delShare").click(delPost);
            }
        });
    });
    
    var view = function(){
        var shareid = $(this).parents(".shareMain").attr("id");
        var win = window.open('viewShare.jsp?sid='+shareid, '_blank');
        if (win) {
            //Browser has allowed it to be opened
            win.focus();
        } else {
            //Browser has blocked it
            alert('Please allow popups for this website');
        }
    };
    
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
                                  //$("#postscontainer").prepend(data);
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
                                //$("#postscontainer").prepend(data);
                                $(".like-btn-text").on("click",function(){ // undo like click
                                        if($(this).hasClass("active")){
                                              $(this).text("Like").removeClass().addClass('like-btn-text');
                                              $(this).siblings(".like-btn-emo").removeClass().addClass('like-btn-emo').addClass("like-btn-default");
                                              $.ajax({
                                                  type : "POST",
                                                  url : "ReactDB.jsp",
                                                  data : "action=deleteReact&ShareId="+shareid,
                                                  success : function(data) {
                                                      //$("#postscontainer").prepend(data);
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
                        //$("#postscontainer").prepend(data);
                    }
                });
                if(divParent.hasClass("visible")){
                    divParent.css({'display':'none',transition : 'all 1s ease-in-out'});
                    divParent.removeClass("visible");
                }
            };
    var lkcncl = function(){ // undo like click
                    if($(this).hasClass("active")){
                          $(this).text("Like").removeClass().addClass('like-btn-text');
                          $(this).siblings(".like-btn-emo").removeClass().addClass('like-btn-emo').addClass("like-btn-default");
                          $.ajax({
                              type : "POST",
                              url : "ReactDB.jsp",
                              data : "action=deleteReact&ShareId="+shareid,
                              success : function(data) {
                                  //$("#postscontainer").prepend(data);
                              }
                          }); 
                    }	  
            };
    
     
    $("#postShare").click(function() {
        sharettl = $("#shareTtl").val();
        body = $("#shareBdy").val();
        hash_1 = $("#hash1").val();
        hash_2 = $("#hash2").length >0 ? $("#hash2").val() : "xnull";
        hash_3 = $("#hash3").length >0 ? $("#hash3").val() : "xnull";
        hash_4 = $("#hash4").length >0 ? $("#hash4").val() : "xnull";
        hash_5 = $("#hash5").length >0 ? $("#hash5").val() : "xnull";
        link = $("#shareLink").length >0 ? $("#shareLink").val(): "xnull";
        type = $("#catgry>option:selected").text();
        $.ajax({
            type : "POST",
            url : "postShare.jsp",
            data : "ttl=" + sharettl + "&body=" + body +"&catgry="+type+ "&hash1="+hash_1+ "&hash2="+hash_2+ "&hash3="+hash_3+ "&hash4="+hash_4+ "&hash5="+hash_5+ "&slink="+link,
            success : function(data) {
                newCont = "<div id=\"tempAlert\" class=\"alert alert-success\">" +
                          "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                          "<strong>Success!</strong> The share has been posted." +
                          "</div>";
                $("#postscontainer").prepend(newCont);
                setTimeout(function() {
                    $("#tempAlert").remove();
                }, 5000);
                // for error check
                newCont2 = "<div id=\"tempAlert2\" class=\"alert alert-success\">" +
                          "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" +
                          data +
                          "</div>";
                $("#postscontainer").prepend(newCont2);
                /*setTimeout(function() {
                    $("#tempAlert2").remove();
                }, 5000);*/
            }
        });
    });     
});
</script>
<script src="js/FB.js"></script>
</body>
</html>
