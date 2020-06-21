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
			cview = "ViewUser";
		});
	});
 });
</script>

<div class="w3-bar w3-red">
	<a class="vT w3-bar-item w3-button" id="LogoutController" href="#"> <i class="fa fa-home" aria-hidden="true"></i> </a>
	<a class="vTl w3-bar-item w3-button w3-hide-small" id="Following" href=#> Timeline </a>
	<a class="menu w3-bar-item w3-button w3-hide-small w3-right" id="LogoutController" href=#><i class="fa fa-sign-out" aria-hidden="true"></i></a>
	<form class="sU w3-bar-item w3-button w3-hide-small w3-right" method="POST" target="_blank">
	<input type="search" name="searchWords" id="searchWords" placeholder="Search for users">
	<input type="submit" class="w3-button w3-small w3-padding-small w3-theme w3-round-xxlarge" value="Search">
	</form>
	<a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="stack()">&#9776;</a>
</div>

<div id="stack" class="w3-bar-block w3-red w3-hide w3-hide-large w3-hide-medium">
	<a class="menu w3-bar-item w3-button" id="LogoutController" href=#> Logout </a>
</div>