<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="true"%>

    
<script>

start = 0;
nt = 8;
cview = "GetTweetsFromUser";
uid = "${viewuser.uid}"; //uid of view user.
	
$(document).ready(function(){
$('#navigation').load('MenuController', function(){
	$("#duser").load( "GetUserInfo", { uid:  uid } ,function() {});
	$("#dtweets").load( "GetTweetsFromUser", { uid: uid, start: start , end: start+nt } ,function() {
		start = nt;
		cview = "GetTweetsFromUser";
	});
	
	// *******************************************************************************************//
	// Elements $("#id").click(...)  caputure clicks of elements that have been statically loaded //
	// *******************************************************************************************//
	
	/* Get and visualize user follows*/
	$(".vF").click(function(event){
		event.preventDefault();
		$.post("changeSessionVar", {setVar: "viewuser", getVar:"user", mode: 1}, function(data){
			$.post("changeSessionVar", {setVar: "defaultDtweets", getVar:"GetFollows", mode: 2}, function(data){
				$("#content").load( "ViewLoginDone.jsp", function(){
				});
			});
		});
	});
	/* Get and visualize Tweets from a given user */
	$(".vT").click(function(event){
		event.preventDefault();
		$.post("changeSessionVar", {setVar: "viewuser", getVar:"user", mode: 1}, function(data){
			$.post("changeSessionVar", {setVar: "defaultDtweets", getVar: "GetTweetsFromUser", mode: 2}, function(data){
				start=0;
				nt=8;
				$("#content").load( "ViewLoginDone.jsp");
			});
		});
	});
	
	/* Get and visualize Tweets from a given user */
	$(".vTl").click(function(event){
		event.preventDefault();
		$.post("changeSessionVar", {setVar: "viewuser", getVar:"user", mode: 1}, function(data){
			$.post("changeSessionVar", {setVar: "defaultDtweets", getVar: "GetAllTweets", mode: 2}, function(data){
				start=0;
				nt=8;
				$("#content").load( "ViewLoginDone.jsp");
			});
		});
	});
	
	/* Get and visualize Tweets from users that is following */
	$(".vFTl").click(function(event){
		event.preventDefault();
		$.post("changeSessionVar", {setVar: "viewuser", getVar:"user", mode: 1}, function(data){
			$.post("changeSessionVar", {setVar: "defaultDtweets", getVar: "GetAllTweetsFollowing", mode: 2}, function(data){
				start=0;
				nt=8;
				$("#content").load( "ViewLoginDone.jsp");
			});
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