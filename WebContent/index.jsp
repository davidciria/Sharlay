<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> Sharlay </title>
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-purple.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css">
<script type="text/javascript">

var start = 0;
var nt = 4;

$(document).ready(function(){
	$.ajaxSetup({ cache: false }); //Avoids Internet Explorer caching!	
	$("body").on("click",".menu",function(event) {
		$('#content').load('ContentController',{content: $(this).attr('id')});
		event.preventDefault();
	});
	
	$("body").on("submit","form", function(event) {
		if($(this).attr('action') != "#"){
			$('#content').load($(this).attr('action'),$(this).serialize());
		    event.preventDefault();
		}
	});
	
	// ***************************************************************************************************//
	// Elements $("body").on("click","...)  caputure clicks of elements that have been dinamically loaded //
	// ***************************************************************************************************//
	
	/* Delete tweet from user */
	$("body").on("click",".dT",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		var tweet = $(this).parent();
		$.post( "DelTweetFromUser", { tweetid: $(this).parent().attr("id") } , function(data) {
			tweet.remove();
			start = start - 1;
	  	});
	});
	

	/* Like tweet from user */
	$("body").on("click",".lT",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		var tweet = $(this).parent();
		var icon = $(this);
		$.post( "LikeTweet", { tweetid: $(this).parent().attr("id") } , function(data, status) {
			if(status == "success"){
				icon.removeClass("lT").addClass("dlT");
				icon.removeClass("w3-theme-l5").addClass("w3-theme-d1");
			}
	  	}).fail(function(response, status) {
	  		console.log("Some problem trying to like tweet.");
	  	});
	});
	
	/* Dislike tweet from user */
	$("body").on("click",".dlT",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		var tweet = $(this).parent();
		var icon = $(this);
		$.post( "DislikeTweet", { tweetid: $(this).parent().attr("id") } , function(data, status) {
			if(status == "success"){
				icon.removeClass("dlT").addClass("lT");
				icon.removeClass("w3-theme-d1").addClass("w3-theme-l5");
			}
		}).fail(function(response, status) {
			console.log("Some problem trying to dislike tweet.");
	  	});
	});
	
	/* Edit tweet from user */
	$("body").on("click",".eT",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		var tweetid = $(this).parent().attr("id");
		var tweetText = $(this).parent().find("#tweetText");
		var prevText = tweetText.text();
		var editButton = $(this);
		var trashButton = editButton.prev();
		var undoButton = $('<button type="button" class="w3-button w3-red w3-margin-bottom w3-right w3-round-medium"><i class="fa fa-undo"></i></button>');
		var saveButton = $('<button type="button" class="w3-button w3-green w3-margin-bottom w3-right w3-round-medium" style="margin-left: -5px"><i class="fa fa-floppy-o"></i></button>'); 
		
		tweetText.prop("contentEditable", true);
        editButton.replaceWith(undoButton);
        trashButton.replaceWith(saveButton);
        saveButton.on("click",function(event){
    		event.preventDefault();
    		$.post( "SaveEditTweetFromUser", { tweetid: tweetid, tweetText: tweetText.text() } , function(data) {
    			tweetText.prop("contentEditable", false);
    			undoButton.replaceWith(editButton);
    			saveButton.replaceWith(trashButton);
    		});
    	});
        undoButton.on("click",function(event){
    		event.preventDefault();
    		tweetText.text(prevText);
    		tweetText.prop("contentEditable", false);
    		undoButton.replaceWith(editButton);
			saveButton.replaceWith(trashButton);
    	});
	});
	
	/* Follow user */
	$("body").on("click",".fU",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		console.log("button follow" + "${viewuser.username}");
		var followButton = $(this);
		var user = $(this).parent().parent();
		var unfollowButton = $('<button type="button" class="uU w3-button w3-red w3-margin-bottom"><i class="fa fa-minus-circle"></i>&nbsp;Unfollow</button>');
		console.log(user.attr("id"));
		$.post( "FollowUser", { uid: user.attr("id") } , function(data) {
			//followButton.replaceWith(unfollowButton);
			$("#duser").load( "GetUserInfo", { uid:  user.attr("id") } ,function() {});
	  	});
	});
	
	/* Unfollow user */
	$("body").on("click",".uU",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		console.log("button unfollow");
		var unfollowButton = $(this);
		var user = $(this).parent().parent();
		console.log(user.attr("id"));
		var followButton = $('<button type="button" class="fU w3-button w3-green w3-margin-bottom"><i class="fa fa-plus-circle"></i>&nbsp;Follow</button>');
		$.post( "UnfollowUser", { uid: user.attr("id") } , function(data) {
			//unfollowButton.replaceWith(followButton);
			$("#duser").load( "GetUserInfo", { uid:  user.attr("id") } ,function() {});
	  	});
	});
	
	/* Unfollow user */
	$("body").on("click",".uF",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		console.log("button unfollow");
		var unfollowButton = $(this);
		var user = $(this).parent().parent();
		$.post( "UnfollowUser", { uid: user.attr("id") } , function(data) {
			user.remove();
	  	});
	});
	
	/* Edit Profile */
	$("body").on("click", ".eP",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		$("#dtweets").load( "EditProfileForm", {firstname: null, lastname: null, username: null } , function(data) {
			start = nt;
			cview = "EditProfileForm";
		});
	});
	
	$("body").on("click", ".uVw", function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		console.log("clicking");
		$("#content").load( "ViewUser", { viewusername: $(this).text() } , function(data) {
			start = 0;
			cview = "ViewUser";
		});
	});
	
	/* Get and visualize user follows*/
	$("body").on("click",".vF",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		console.log("times");
		var user = $(this).parent().parent().parent().parent();
		$.post("changeSessionVar", {setVar: "defaultDtweets", getVar:"GetFollows", mode: 2}, function(data){
			$("#dtweets").load( "GetFollows", { uid: user.attr("id"), start: 0 , end: nt } , function(data) {
				start = nt;
				cview = "GetFollows";
			});
		});
	});
	/* Get and visualize user followers*/
	$("body").on("click",".vS",function(event){
		event.preventDefault();
		//event.stopImmediatePropagation();
		var user = $(this).parent().parent().parent().parent();
		$.post("changeSessionVar", {setVar: "defaultDtweets", getVar:"GetFollowers", mode: 2}, function(data){
			$("#dtweets").load( "GetFollowers", { uid: user.attr("id"), start: 0 , end: nt } , function(data) {
				start = nt;
				cview = "GetFollowers";
			});
		});
	});
	
});
</script>
</head>
<body>

 	<!-- Begin Navigation -->
 	<div class="w3-bar w3-red" id="navigation">
    <jsp:include page="${menu}" />
 	</div>
 	<!-- End Navigation -->
 
	<!-- Begin Content -->
	<div class="w3-container w3-card-4 w3-padding-24" id="content">
	<jsp:include page="${content}" />
	</div>
	<!-- End Content -->
	
	<script>
		function stack() {
  			var x = document.getElementById("stack");
  			if (x.className.indexOf("w3-show") == -1) {
    			x.className += " w3-show";
  			} else { 
    		x.className = x.className.replace(" w3-show", "");
  			}
		}
	</script>

  </body>
</html>