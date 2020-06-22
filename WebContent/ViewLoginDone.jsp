<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>

<script>
var start = 0;
var nt = 4;
var cview = "${defaultDtweets}";
var uid = "${user.uid}";
	
$(document).ready(function(){
$('#navigation').load('MenuController', function(){
	$("#duser").load( "GetUserInfo", { uid:  uid } ,function() {});
	$("#dtweets").load("${defaultDtweets}", { uid: uid, start: start , end: start+nt } ,function() {
		start = nt;
		cview = "${defaultDtweets}";
	});
	
	/* Infinite scrolling */
	$(window).scroll(function(event) {
		event.preventDefault();
		if(Math.ceil($(window).scrollTop()) == $(document).outerHeight() - $(window).outerHeight()) {
			$.post( cview , { uid: uid, start: start , end: start+nt } , function(data) {
	    	  	$("#dtweets").append(data);
	    		start = start + nt;
	   		});
	    }
	});
	
	// *******************************************************************************************//
	// Elements $("#id").click(...)  caputure clicks of elements that have been statically loaded //
	// *******************************************************************************************//
	
	/* Get and visualize user follows*/
	$("body").on("click",".vF",function(event){
		event.preventDefault();
		event.stopImmediatePropagation();
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
		event.stopImmediatePropagation();
		var user = $(this).parent().parent().parent().parent();
		$.post("changeSessionVar", {setVar: "defaultDtweets", getVar:"GetFollowers", mode: 2}, function(data){
			$("#dtweets").load( "GetFollowers", { uid: user.attr("id"), start: 0 , end: nt } , function(data) {
				start = nt;
				cview = "GetFollowers";
			});
		});
	});
	/* Get and visualize Tweets from a given user */
	$(".vT").click(function(event){
		event.preventDefault();
		event.stopImmediatePropagation();
		$.post("changeSessionVar", {setVar: "defaultDtweets", getVar: "GetTweetsFromUser", mode: 2}, function(data){
			$("#dtweets").load( "GetTweetsFromUser", { uid: uid, start: 0 , end: nt } , function(data) {
				start = nt;
				cview = "GetTweetsFromUser";
			});
		});
	});
	
	/* Get and visualize Tweets from a given user */
	$(".vTl").click(function(event){
		event.preventDefault();
		event.stopImmediatePropagation();
		$.post("changeSessionVar", {setVar: "defaultDtweets", getVar: "GetAllTweets", mode: 2}, function(data){
			$("#dtweets").load( "GetAllTweets", { uid: uid, start: 0 , end: nt } , function(data) {
				start = nt;
				cview = "GetAllTweets";
			});
		});
	});
	
	/* Add tweet and reload Tweet Visualitzation */
	$("#aT").click(function(event){
		event.preventDefault();
		event.stopImmediatePropagation();
		$.post( "AddTweetFromUser", { uid: uid, text: $("#cT").text() } , function(data) {
			$("#dtweets").load( "GetTweetsFromUser", { uid: uid, start: 0 , end: nt } ,function() {
				start = nt;
				cview = "GetTweetsFromUser";
			});
   		});
	});
	
	// ***************************************************************************************************//
	// Elements $("body").on("click","...)  caputure clicks of elements that have been dinamically loaded //
	// ***************************************************************************************************//
	
	/* Delete tweet from user */
	$("body").on("click",".dT",function(event){
		event.preventDefault();
		event.stopImmediatePropagation();
		var tweet = $(this).parent();
		$.post( "DelTweetFromUser", { tweetid: $(this).parent().attr("id") } , function(data) {
			tweet.remove();
			start = start - 1;
	  	});
	});
	

	/* Like tweet from user */
	$("body").on("click",".lT",function(event){
		event.preventDefault();
		event.stopImmediatePropagation();
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
		event.stopImmediatePropagation();
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
		event.stopImmediatePropagation();
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
	
	/* Save edit tweet from user */
	//$("body").on("click",".seT",function(event){
		//event.preventDefault();
		//var tweet = $(this).parent();
		//var tweetText = $('#tweetText');
		//var editButton = $(this).prev();
		//
		//$.post( "SaveEditTweetFromUser", { tweetid: $(this).parent().attr("id"), tweetText: $('#tweetText').text() } , function(data) {
			//tweetText.prop("contentEditable", false);
			//$(this).remove();
			//editButton.removeClass("uC").addClass("eT");
		//});
	//});
	
	/* Follow user */
	$("body").on("click",".fU",function(event){
		event.preventDefault();
		event.stopImmediatePropagation();
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
		event.stopImmediatePropagation();
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
		event.stopImmediatePropagation();
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
		event.stopImmediatePropagation();
		$("#dtweets").load( "EditProfileForm", {firstname: null, lastname: null, username: null } , function(data) {
			start = nt;
			cview = "EditProfileForm";
		});
	});
	
	$("body").on("click", ".uVw", function(event){
		event.preventDefault();
		event.stopImmediatePropagation();
		console.log("clicking");
		$("#content").load( "ViewUser", { viewusername: $(this).text() } , function(data) {
			start = 0;
			cview = "ViewUser";
		});
	});

});
});
</script>

<!-- Page Container -->
<div class="w3-container w3-content" style="max-width:1400;margin-top:80px">    
  <!-- The Grid -->
  <div class="w3-row">
  
    <!-- Left Column -->
    <div class="w3-col m3">
      
      <!-- Profile -->
      <div id="duser"> </div>
      
    <!-- End Left Column -->
    </div>
    
    <!-- Middle Column -->
    <div class="w3-col m9">
    
      <div class="w3-row-padding" >
        <div class="w3-col m12">
          <div class="w3-card w3-round w3-white">
            <div class="w3-container w3-padding">
              <h6 class="w3-opacity">What do you want to share?</h6>
              <p id="cT" contenteditable="true" class="w3-border w3-padding">I'm enjoying Sharlay!</p>
              <button id="aT" type="button" class="w3-button w3-theme w3-round-medium w3-right"><i class="fa Example of arrow-circle-o-down fa-arrow-down"></i> &nbsp;Post</button> 
            </div>
          </div>
        </div>
      </div>
      
      <div id="dtweets"> </div>

    <!-- End Middle Column -->
    </div>
    
  <!-- End Grid -->
  </div>
  
<!-- End Page Container -->
</div>
<br>

<!-- Footer -->
<footer class="w3-container w3-theme-d3 w3-padding-16">
  <h5> Avís legal </h5>
</footer>

<footer class="w3-container w3-theme-d5">
  <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
</footer>
 
<script>

// Accordion
function myFunction(id) {
  var x = document.getElementById(id);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
    x.previousElementSibling.className += " w3-theme-d1";
  } else { 
    x.className = x.className.replace("w3-show", "");
    x.previousElementSibling.className = 
    x.previousElementSibling.className.replace(" w3-theme-d1", "");
  }
}

// Used to toggle the menu on smaller screens when clicking on the menu button
function openNav() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>
