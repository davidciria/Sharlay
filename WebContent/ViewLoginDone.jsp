<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>

<script>
start = 0;
nt = 4;
var cview = "${defaultDtweets}";
var uid = "${user.uid}";
	
$(document).ready(function(){
$('#navigation').load('MenuController', function(){
	$("#duser").load( "GetUserInfo", { uid:  uid } ,function() {});
	$("#dtweets").load("${defaultDtweets}", { uid: uid, start: start , end: start+nt } ,function() {
		start = nt;
		cview = "${defaultDtweets}";
	});
	
//Scrolling
	
	// *******************************************************************************************//
	// Elements $("#id").click(...)  caputure clicks of elements that have been statically loaded //
	// *******************************************************************************************//
	
	/* Get and visualize Tweets from a given user */
	$(".vT").click(function(event){
		event.preventDefault();
		console.log("hii");
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
		$.post("changeSessionVar", {setVar: "defaultDtweets", getVar: "GetAllTweets", mode: 2}, function(data){
			$("#dtweets").load( "GetAllTweets", { uid: uid, start: 0 , end: nt } , function(data) {
				start = nt;
				cview = "GetAllTweets";
			});
		});
	});
	
	/* Get and visualize Tweets from a given user */
	$(".vFTl").click(function(event){
		event.preventDefault();
		$.post("changeSessionVar", {setVar: "defaultDtweets", getVar: "GetAllTweetsFollowing", mode: 2}, function(data){
			$("#dtweets").load( "GetAllTweetsFollowing", { uid: uid, start: 0 , end: nt } , function(data) {
				start = nt;
				cview = "GetAllTweetsFollowing";
			});
		});
	});
	
	/* Add tweet and reload Tweet Visualitzation */
	$("#aT").click(function(event){
		event.preventDefault();
		$.post( "AddTweetFromUser", { uid: uid, text: $("#cT").text() } , function(data) {
			$("#dtweets").load( "${defaultDtweets}", { uid: uid, start: 0, end: nt } ,function() {
				start = nt;
				cview = "GetTweetsFromUser";
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
