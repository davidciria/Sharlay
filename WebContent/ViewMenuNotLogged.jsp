<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
    
<div class="w3-bar w3-purple">
	<a class="w3-bar-item w3-button w3-hide-small" id="LogoutController" href="MainController"> <i class="fa fa-home w3-large" aria-hidden="true"></i> </a>
	<a class="vTa w3-bar-item w3-button w3-hide-small" id="GlTimeline" href=#><i class="fa fa-globe w3-large" aria-hidden="true"></i> </a>
	<a class="menu w3-bar-item w3-button w3-hide-small" id="RegisterController" href=#> Registration </a> 
	<a class="menu w3-bar-item w3-button w3-hide-small" id="LoginController" href=#> Login </a> 	
	<a class="w3-hide-medium w3-hide-small"><img src="img/logo_fusion_cut.png" class="w3-circle" style="height:35px; width:35px; margin-top: 0%; margin-left: 35%" alt="Sharlay's logo"></a>
	<a class="w3-hide-large w3-hide-small"><img src="img/logo_fusion_cut.png" class="w3-circle" style="height:35px; width:35px; margin-top: 0%; margin-left: 25%" alt="Sharlay's logo"></a>
	<a class="w3-right w3-hide-large w3-hide-medium"><img src="img/logo_fusion_cut.png" class="w3-circle" style="height:35px; width:35px; margin-top: 0%;" alt="Sharlay's logo"></a>
	<a href="javascript:void(0)" class="w3-bar-item w3-button w3-left w3-hide-large w3-hide-medium" onclick="stack()">&#9776;</a>
</div>

<div id="stack" class="w3-bar-block w3-purple w3-hide w3-hide-large w3-hide-medium">
	<a class="vTa menu w3-bar-item w3-button" id="GlTimeline" href=#> Global Timeline </a>
	<a class="menu w3-bar-item w3-button" id="RegisterController" href=#> Registration </a> 
	<a class="menu w3-bar-item w3-button" id="LoginController" href=#> Login </a> 
</div>
