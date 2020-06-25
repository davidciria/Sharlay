<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>

<script>
/*Search users*/
 $(document).ready(function(){
	$(".sU").submit( function(event){
		event.preventDefault();
		console.log("searching Users");
		$("#dtweets").load( "searchUsers", $(this).serialize() , function(data) {
			start = 0;
			cview = "searchUsers";
		});
	});
 });
</script>

<div class="w3-bar w3-purple">
	<a class="vT w3-bar-item w3-button w3-hide-small" id="Timeline" href="#"> <i class="fa fa-home w3-large" aria-hidden="true"></i> </a>
	<a class="vTl w3-bar-item w3-button w3-hide-small" id="GlTimeline" href=#><i class="fa fa-globe w3-large" aria-hidden="true"></i> </a>
	<a class="vFTl w3-bar-item w3-button w3-hide-small" id="PTimeline" href=#><i class="fa fa-users w3-large" aria-hidden="true"></i> </a>
	<a class="w3-hide-medium w3-hide-small"><img src="img/logo_fusion_cut.png" class="w3-circle" style="height:35px; width:35px; margin-top: 0%; margin-left: 46%" alt="Sharlay's logo"></a>
	<a class="w3-hide-large w3-hide-small"><img src="img/logo_fusion_cut.png" class="w3-circle" style="height:35px; width:35px; margin-top: 0%; margin-left: 25%" alt="Sharlay's logo"></a>
	<a class="w3-right w3-hide-large w3-hide-medium"><img src="img/logo_fusion_cut.png" class="w3-circle" style="height:35px; width:35px; margin-top: 0%;" alt="Sharlay's logo"></a>
	<a class="menu w3-bar-item w3-button w3-hide-small w3-right" id="LogoutController" href=#><i class="fa fa-sign-out w3-large" aria-hidden="true"></i></a>
	<form class="sU w3-right w3-hide-small" style="user-select: none; margin-top: 5px; margin-right: 15px" action="#" method="POST" target="_blank">
	<input type="search" name="searchWords" id="searchWords" placeholder="Search for users">
	<input type="submit" class="w3-button w3-small w3-padding-small w3-theme w3-round-xxlarge" style="margin-bottom: 3px" value="Search">
	</form>
	<a href="javascript:void(0)" class="w3-bar-item w3-button w3-hide-large w3-hide-medium w3-left" onclick="stack()">&#9776;</a>
</div>

<div id="stack" class="w3-bar-block w3-purple w3-hide w3-hide-large w3-hide-medium">
	<a class="vT menu w3-bar-item w3-button" id="Timeline" href=#> Personal Page </a>
	<a class="vTl menu w3-bar-item w3-button" id="GlTimeline" href=#> Global Timeline </a>
	<a class="vFTl w3-bar-item w3-button" id="PTimeline" href=#> Personalized Timeline </a>
	<a class="menu w3-bar-item w3-button" id="LogoutController" href=#> Logout </a>
	<form class="sU" style="user-select: none; margin-top: 5px; margin-left: 40%" action="#" method="POST" target="_blank">
	<input type="search" name="searchWords" id="searchWords" placeholder="Search for users">
	<input type="submit" class="w3-button w3-small w3-padding-small w3-theme  w3-round-xxlarge" style="margin-bottom: 3px" value="Search">
	</form>
</div>