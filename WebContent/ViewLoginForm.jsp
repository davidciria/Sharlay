<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Parsley JS -->
<script src="parsley/parsley.min.js"></script>
<!-- Scripts -->
<script>
$(document).ready(function(){
	
	 $(".editinput").keyup(function(){
		  var instance = $(this).parsley();
			if($(this).val() == ""){
				$(this).attr("class", "w3-input w3-border form-bg w3-text");
			}else{
				if(instance.isValid()) $(this).attr("class", "w3-input w3-border w3-border-green w3-hover-border-green form-bg w3-text");
				else $(this).attr("class", "w3-input w3-border w3-border-red form-bg w3-text");
			}
	  });
	  
	});
</script>

<ul>
<c:if test = "${registered}">
	<script>
	$(document).ready(function(){
		$.post("VerificationEmailSenderController",
			    {
			      name: '${username}',
			      mail: '${mail}'
			    },
			    function(data,status){
			      
			    });
	});
     </script>
	<div class="w3-center  w3-text-green"> User has been registered correctly, please verify your email before login </div>
</c:if>
</ul>

<div class="w3-center w3-text-green">
<c:if test = "${verified == 1}">
	 User has been verified correctly, now you can log in <br>
</c:if>
<c:if test = "${verified == 3}">
	User already verified <br>
</c:if>
</div>
<div class="w3-center w3-text-red">
<c:if test = "${verified == 2}">
	There has been a problem verifiying user, please try again later <br>
</c:if>
</div>


<div class="server-errors-list w3-center">
<c:if test = "${login.error[0]}">
	Mail format is not correct <br>
</c:if>
<c:if test = "${login.error[1]}">
	 Password format is not correct <br> 
</c:if>
<c:if test = "${db_error == 1}">
	 Password is not correct <br>
</c:if>
<c:if test = "${db_error == 2}">
	 User is not registered  <br>
</c:if>
<c:if test = "${db_error == 3}">
	 Cannot reach the server <br>
</c:if>
<c:if test = "${db_error == 4}">
	 You have to verify your email <br>
</c:if>
</div>
<div class="w3-row">
  	<div class="w3-container w3-quarter">
	</div> 
	<div  class="w3-container w3-card w3-text w3-round w3-margin w3-animate-opacity w3-half">  
		<form action="LoginController" method="POST">
			<p>      
		    <label class="imp-text"><b> Email </b></label>
		    <input class="editinput w3-input w3-border form-bg w3-text" type="email" name="mail" placeholder="Email" value="${login.mail}" required></p>
		    <p>
		    <p>      
		    <label class="imp-text"><b> Password </b></label>
		    <input class="editinput w3-input w3-border form-bg w3-text" type="password" name="pwd" placeholder="Password" value="${login.pwd}" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"></p>
		    <p>
		    <input class="w3-button w3-theme w3-round-medium" type="submit" name="sumbit" value="Submit"></p>
		</form>
	</div>
	<div class="w3-container w3-quarter">
	</div>
</div>   