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


<div class="server-errors-list w3-center">
<c:if test = "${model.error[0]}">
	 First or Last name format is not correct <br>
</c:if>
<c:if test = "${model.error[1]}">
	Entered user name is invalid or has been already registered <br>
</c:if>
<c:if test = "${model.error[2]}">
	 Entered email is invalid or has been already registered <br>
</c:if>
<c:if test = "${model.error[3]}">
	 Password format is not valid <br>
</c:if>
<c:if test = "${model.error[4]}">
	The second password must be the same <br>
</c:if>
<c:if test = "${model.error[5]}">
	 You are not yet 16 years old <br>
</c:if>
</div>
 <div class="w3-row">
  	<div class="w3-container w3-quarter">
	</div> 
	<div  class="w3-container w3-card w3-text w3-round w3-margin w3-animate-opacity w3-half">  
		<form data-parsley-validate action="RegisterController" method="POST">
			<p>      
		    <label class="imp-text"><b> First Name </b></label>
		    <input class="editinput w3-input w3-border form-bg w3-text" type="text" id="firstname" name="firstname" placeholder="First Name" value="${model.firstname}" required pattern="^[a-zA-Z0-9_ ]+$" data-parsley-maxlength="50"></p>
		    <p>     
		    <label class="imp-text"><b> Last Name </b></label>
		    <input class="editinput w3-input w3-border form-bg w3-text" type="text" id="lastname" name="lastname" placeholder="Last Name" value="${model.lastname}" required pattern="^[a-zA-Z0-9_ ]+$" data-parsley-maxlength="50"></p>
		    <p>    
		    <label class="imp-text"><b> Username </b></label>
		    <input class="editinput w3-input w3-border form-bg w3-text" type="text" id="username" name="username" placeholder="Username" value="${model.username}" required pattern="^[a-zA-Z0-9_]+$"></p>
		    <p>
		    <label class="imp-text"><b> Mail address </b></label>
		    <input class="editinput w3-input w3-border form-bg w3-text" type="email" id="mail" name="mail" placeholder="Email" value="${model.mail}" required></p>
		    <p>
		    <label class="imp-text"><b> Password </b></label>
		    <input class="editinput w3-input w3-border form-bg w3-text" type="password" id="pwd1" name="pwd1" placeholder="Password" value="${model.pwd1}" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"></p>
		    <p>
		    <label class="imp-text"><b> Confirm password </b></label>
		    <input class="editinput w3-input w3-border form-bg w3-text" type="password" id="pwd2" name="pwd2" placeholder="Confirm Password" value="${model.pwd2}" required data-parsley-equalto="#pwd1"></p>
		    <p>
		    <label class="imp-text"><b> Birthday </b></label>
		    <input class="editinput w3-input w3-border form-bg w3-text" type="date" id="birth" name="birth" value="${model.birth}" required data-parsley-min-age="16"></p>
		    <p>
		    <input class="w3-button w3-purple w3-round-medium" type="submit" name="sumbit" value="Submit"></p>
		</form>
	</div>
	<div class="w3-container w3-quarter">
	</div>
</div>   