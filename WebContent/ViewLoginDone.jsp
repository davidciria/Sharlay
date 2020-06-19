<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>

<script type="text/javascript">
$('#navigation').load('MenuController');
</script>

<script>
var start = 0;
var nt = 4;
var cview = "GetTweetsFromUser";
var uid = "${user.uid}";

$(document).ready(function(){
	
	$("#duser").load( "GetUserInfo", { uid:  uid } ,function() {});
	$("#dtweets").load( "GetTweetsFromUser", { uid: uid, start: start , end: start+nt } ,function() {
		start = nt;
		cview = "GetTweetsFromUser";
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
	$(".vF").click(function(event){
		event.preventDefault();
		$("#dtweets").load( "GetFollows", { uid: uid, start: 0 , end: nt } , function(data) {
			start = nt;
			cview = "GetFollows";
		});
	});
	/* Get and visualize Tweets from a given user */
	$(".vT").click(function(event){
		event.preventDefault();
		$("#dtweets").load( "GetTweetsFromUser", { uid: uid, start: 0 , end: nt } , function(data) {
			start = nt;
			cview = "GetTweetsFromUser";
		});
	});
	/* Add tweet and reload Tweet Visualitzation */
	$("#aT").click(function(event){
		event.preventDefault();
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
		var tweet = $(this).parent();
		$.post( "DelTweetFromUser", { tweetid: $(this).parent().attr("id") } , function(data) {
			tweet.remove();
			start = start - 1;
	  	});
	});
	

	/* Like tweet from user */
	$("body").on("click",".lT",function(event){
		event.preventDefault();
		var tweet = $(this).parent();
		var icon = $(this);
		$.post( "LikeTweet", { tweetid: $(this).parent().attr("id") } , function(data) {
			icon.addClass("dlT");
			icon.removeClass("lT");
			icon.addClass("w3-theme-d1");
			icon.removeClass("w3-theme-l5");
			start = start - 1;
	  	});
	});
	
	/* Dislike tweet from user */
	$("body").on("click",".dlT",function(event){
		event.preventDefault();
		var tweet = $(this).parent();
		var icon = $(this);
		$.post( "DislikeTweet", { tweetid: $(this).parent().attr("id") } , function(data) {
			icon.addClass("lT");
			icon.removeClass("dlT");
			icon.addClass("w3-theme-l5");
			icon.removeClass("w3-theme-d1");
		});
	});
	
	/* Unfollow user */
	$("body").on("click",".uF",function(event){
		event.preventDefault();
		var user = $(this).parent();
		$.post( "UnfollowUser", { uid: $(this).parent().attr("id") } , function(data) {
			user.remove();
			start = start - 1;
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
              <h6 class="w3-opacity"> EPAW template by UPF </h6>
              <p id="cT" contenteditable="true" class="w3-border w3-padding">Status: Feeling EPAW</p>
              <button id="aT" type="button" class="w3-button w3-theme"><i class="fa fa-pencil"></i> &nbsp;Post</button> 
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
