<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>

<script>
/*Search users*/
 $(document).ready(function(){
	$(".sU").submit( function(event){
		event.preventDefault();
		$("#content").load( "searchUsers", $(this).serialize() , function(data) {
			start = 0;
			cview = "searchUsersFromAnonymous";
		});
	});
 });
</script>    
    
<div class="w3-bar w3-theme">
	<a class="w3-bar-item w3-button w3-hide-small" id="LogoutController" href="MainController"> <i class="fa fa-home w3-large" aria-hidden="true"></i> </a>
	<a class="vTa w3-bar-item w3-button w3-hide-small" id="GlTimeline" href=#><i class="fa fa-globe w3-large" aria-hidden="true"></i> </a>
	<a class="menu w3-bar-item w3-button w3-hide-small" id="RegisterController" href=#><i class="fa fa-user-plus w3-large" aria-hidden="true"></i> </a> 
	<a class="menu w3-bar-item w3-button w3-hide-small w3-right" id="LoginController" href=#><i class="fa fa-sign-in w3-large" aria-hidden="true"></i> </a> 	
	<a class="w3-hide-medium w3-hide-small"><img src="img/logo_fusion_cut.png" class="w3-circle" style="height:35px; width:35px; margin-top: 0%; margin-left: 40%" alt="Sharlay's logo"></a>
	<a class="w3-hide-large w3-hide-small"><img src="img/logo_fusion_cut.png" class="w3-circle" style="height:35px; width:35px; margin-top: 0%; margin-left: 25%" alt="Sharlay's logo"></a>
	<a class="w3-right w3-hide-large w3-hide-medium"><img src="img/logo_fusion_cut.png" class="w3-circle" style="height:35px; width:35px; margin-top: 0%;" alt="Sharlay's logo"></a>
	<form class="sU w3-right w3-hide-small" style="user-select: none; margin-top: 5px; margin-right: 15px" action="#" method="POST" target="_blank">
	<input class="w3-border form-bg w3-text" type="search" name="searchWords" id="searchWords" placeholder="Search for users">
	<input type="submit" class="w3-button w3-small w3-padding-small w3-theme w3-round-xxlarge" style="margin-bottom: 3px" value="Search">
	</form>
	<a href="javascript:void(0)" class="w3-bar-item w3-button w3-left w3-hide-large w3-hide-medium" onclick="stack()">&#9776;</a>
</div>

<div id="stack" class="w3-bar-block w3-theme w3-hide w3-hide-large w3-hide-medium">
	<a class="vTa menu w3-bar-item w3-button" id="GlTimeline" href=#> Global Timeline </a>
	<a class="menu w3-bar-item w3-button" id="RegisterController" href=#> Registration </a> 
	<a class="menu w3-bar-item w3-button" id="LoginController" href=#> Login </a> 
	<form class="sU w3-margin" style="user-select: none; margin-top: 5px" action="#" method="POST" target="_blank">
	<input class="w3-input w3-border form-bg w3-text" type="search" name="searchWords" id="searchWords" placeholder="Search for users">
	<input type="submit" class="w3-button w3-small w3-padding-small w3-theme  w3-round-xxlarge" style="margin-bottom: 3px" value="Search">
	</form>
</div>
