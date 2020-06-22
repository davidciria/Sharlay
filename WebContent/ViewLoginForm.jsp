<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Parsley JS -->
<script src="parsley/parsley.min.js"></script>
<!-- Scripts -->
<script>
$(document).ready(function(){
	
	  $("input").keyup(function(){
		  var instance = $("input").parsley();
		  for(var i = 0; i < instance.length - 1; i++){
			console.log(i, instance[i].isValid());
			if($("input").eq(i).val() == ""){
				$("input").eq(i).attr("class", "w3-input w3-border w3-light-grey");
			}else{
				if(instance[i].isValid()) $("input").eq(i).attr("class", "w3-input w3-border w3-border-green w3-hover-border-green w3-light-grey");
				else $("input").eq(i).attr("class", "w3-input w3-border w3-border-red w3-light-grey");
			}
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
	<li> User has been registered correctly, please verify your email before login </li>
</c:if>
</ul>

<ul>
<c:if test = "${verified == 1}">
	<li> User has been verified correctly, now you can log in </li>
</c:if>
<c:if test = "${verified == 2}">
	<li> There has been a problem verifiying user, please try again later </li>
</c:if>
</ul>

<ul class="server-errors-list">
<c:if test = "${login.error[0]}">
	<li> Mail format is not correct </li>
</c:if>
<c:if test = "${login.error[1]}">
	<li> Password format is not correct </li>
</c:if>
<c:if test = "${db_error == 1}">
	<li> Password is not correct </li>
</c:if>
<c:if test = "${db_error == 2}">
	<li> User is not registered </li>
</c:if>
<c:if test = "${db_error == 3}">
	<li> Cannot reach the server </li>
</c:if>
<c:if test = "${db_error == 4}">
	<li> You have to verify your email </li>
</c:if>
</ul>

<form action="LoginController" method="POST">
	<p>      
    <label class="w3-text-purple"><b> Email </b></label>
    <input class="w3-input w3-border w3-light-grey" type="email" name="mail" value="${login.mail}" required></p>
    <p>
    <p>      
    <label class="w3-text-purple"><b> Password </b></label>
    <input class="w3-input w3-border w3-light-grey" type="password" name="pwd" value="${login.pwd}" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"></p>
    <p>
    <input class="w3-button w3-purple w3-round-medium" type="submit" name="sumbit" value="Submit"></p>
</form>