<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="models.User" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Parsley JS -->
<script src="parsley/parsley.min.js"></script>
<!-- Scripts -->
<script type="text/javascript">
/* add validation for minimum age */
window.Parsley.addValidator("minAge", {
	validateString: function(value, requirements) {
		// get validation requirments
		var reqs = value.split("/"),
			day = reqs[0],
			month = reqs[1],
			year = reqs[2];

		// check if date is a valid
		var birthday = new Date(year + "-" + month + "-" + day);

		// Calculate birtday and check if age is greater than 18
		var today = new Date();

		var age = today.getFullYear() - birthday.getFullYear();
		var m = today.getMonth() - birthday.getMonth();
		if (m < 0 || (m === 0 && today.getDate() < birthday.getDate())) {
			age--;
		}

		return age >= requirements;
	},
	messages: {
	    en: 'You are less than %s.'
	}
});
</script>
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


<ul class="server-errors-list">
<c:if test = "${model.error[0]}">
	<li> First or Last name format is not correct </li>
</c:if>
<c:if test = "${model.error[1]}">
	<li> Entered user name is invalid or has been already registered </li>
</c:if>
<c:if test = "${model.error[2]}">
	<li> Entered email is invalid or has been already registered </li>
</c:if>
<c:if test = "${model.error[3]}">
	<li> Password format is not valid </li>
</c:if>
<c:if test = "${model.error[4]}">
	<li> The second password must be the same </li>
</c:if>
<c:if test = "${model.error[5]}">
	<li> You are not yet 16 years old </li>
</c:if>
</ul>

<form data-parsley-validate action="RegisterController" method="POST">
	<p>      
    <label class="w3-text-purple"><b> First Name </b></label>
    <input class="w3-input w3-border w3-light-grey" type="text" id="firstname" name="firstname" placeholder="First Name" value="${model.firstname}" required pattern="^[a-zA-Z0-9_ ]+$" data-parsley-maxlength="50"></p>
    <p>     
    <label class="w3-text-purple"><b> Last Name </b></label>
    <input class="w3-input w3-border w3-light-grey" type="text" id="lastname" name="lastname" placeholder="Last Name" value="${model.lastname}" required pattern="^[a-zA-Z0-9_ ]+$" data-parsley-maxlength="50"></p>
    <p>    
    <label class="w3-text-purple"><b> Username </b></label>
    <input class="w3-input w3-border w3-light-grey" type="text" id="username" name="username" placeholder="Username" value="${model.username}" required pattern="^[a-zA-Z0-9_]+$"></p>
    <p>
    <label class="w3-text-purple"><b> Mail address </b></label>
    <input class="w3-input w3-border w3-light-grey" type="email" id="mail" name="mail" placeholder="Email" value="${model.mail}" required></p>
    <p>
    <label class="w3-text-purple"><b> Password </b></label>
    <input class="w3-input w3-border w3-light-grey" type="password" id="pwd1" name="pwd1" placeholder="Password" value="${model.pwd1}" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"></p>
    <p>
    <label class="w3-text-purple"><b> Confirm password </b></label>
    <input class="w3-input w3-border w3-light-grey" type="password" id="pwd2" name="pwd2" placeholder="Confirm Password" value="${model.pwd2}" required data-parsley-equalto="#pwd1"></p>
    <p>
    <label class="w3-text-purple"><b> Birthday </b></label>
    <input class="w3-input w3-border w3-light-grey" type="date" id="birth" name="birth" value="${model.birth}" required data-parsley-min-age="16"></p>
    <p>
    <input class="w3-button w3-purple w3-round-medium" type="submit" name="sumbit" value="Submit"></p>
</form>
