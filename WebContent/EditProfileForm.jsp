<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="models.User" session="false"%>
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
		  var instance = $(".editinput").parsley();
		  for(var i = 0; i < instance.length - 1; i++){
			if($(".editinput").eq(i).val() == ""){
				$(".editinput").eq(i).attr("class", "w3-input w3-border form-bg w3-text");
			}else{
				if(instance[i].isValid()) $(".editinput").eq(i).attr("class", "w3-input w3-border w3-border-green w3-hover-border-green form-bg w3-text");
				else $(".editinput").eq(i).attr("class", "w3-input w3-border w3-border-red form-bg w3-text");
			}
		  }
	  });
	  
	$(".editForm").submit( function(event) {
		event.preventDefault();
		var uid = $(this).attr("id");
		var formParams = $(this).serializeArray();
		var firstname = "${firstname}";
		var lastname = "${lastname}";
		var username = "${username}";
		var birth = "${username}";
		var newfirstname = null;
		var newlastname = null;
		var newusername = null;
		var newbirth = null;
		if(firstname != formParams[0].value) newfirstname = formParams[0].value;
		if(lastname != formParams[1].value) newlastname = formParams[1].value;
		if(username != formParams[2].value) newusername = formParams[2].value;
		if(birth != formParams[3].value) newbirth = formParams[3].value;
		$('#dtweets').load("EditProfileForm",{firstname: newfirstname, lastname: newlastname, username: newusername, birth: newbirth, uid: "${uid}"}, function(data){
			$("#duser").load( "GetUserInfo", { uid:  uid } ,function() {});
		});
	});
	
	$(".editPwdForm").submit( function(event) {
		event.preventDefault();
		var uid = $(this).attr("id");
		var formParams = $(this).serializeArray();
		var currentPwd = formParams[0].value;
		var newPwd = formParams[1].value;
		$.post("ChangePwd",{uid: "${uid}", currentPwd: currentPwd, newPwd: newPwd}, function(data){
			
			 if(data.trim() == "success"){
	    		   $("#passwordUpdatedStatus").removeClass("w3-text-red").addClass("w3-text-green");
	    		   $("#passwordUpdatedStatus").text("Password updated successfully");
	    	   }
	    	   else{
	    		   $("#passwordUpdatedStatus").removeClass("w3-text-green").addClass("w3-text-red");
	    		   $("#passwordUpdatedStatus").text(data);
	    	   }
	    	   
	    	   $("#passwordUpdatedStatus").show();
		});
	});
	
	$(".uploadProfileImage").submit(function(evt){	 
	      evt.preventDefault();
	      var formData = new FormData($(this)[0]);
	      formData.append("uid", $(this).attr("id"));
	      var globaluid = $(this).attr("id");
	   $.ajax({
	       url: 'UploadProfileImage',
	       type: 'POST',
	       data: formData,
	       async: false,
	       cache: false,
	       contentType: false,
	       enctype: 'multipart/form-data',
	       processData: false,
	       success: function (response) {
	    	   var d = new Date();
	    	   $("#profileImage").attr("src", "ProfileImages/" + globaluid + ".png?" + d.getTime());
	    	   //Show success updating profile image.
	    	   if(response.trim() == "success"){
	    		   $("#uploadedSuccessful").removeClass("w3-text-red").addClass("w3-text-green");
	    		   $("#uploadedSuccessful").text("Profile photo uploaded successfully");
	    	   }
	    	   else{
	    		   $("#uploadedSuccessful").removeClass("w3-text-green").addClass("w3-text-red");
	    		   $("#uploadedSuccessful").text("Please upload a file with .png format");
	    	   }
	    	   
	    	   $("#uploadedSuccessful").show();
	       }
	   });
	   
	});
	
	
	$("#confirmDialog").dialog({
        autoOpen: false,
        modal: true
      }).prev(".ui-dialog-titlebar").css("background","purple");
	
	 $("#deleteAccount").click(function(e) {
	       e.preventDefault();
			
	       $("#confirmDialog").dialog({
	           buttons : {
	             "Confirm" : function() {
	               //Delete account.
	               $(this).dialog("close");
	               $("#content").load("DeleteUser", {userToDeleteUid: "${uid}"});
	             },
	             "Cancel" : function() {
	               $(this).dialog("close");
	             }
	           }
	         });
	       
	       $("#confirmDialog").dialog('open');
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

<div id="confirmDialog">Are you sure you want to delete your account?</div>

<div class="w3-container w3-card w3-text w3-round w3-margin w3-animate-opacity">

<!-- Edit user info form -->
<h2><b>Edit personal data</b></h2>
<hr>
<form id="${uid}" data-parsley-validate action="#" method="POST" class="editForm">
	<p>      
    <label class="imp-text"><b> First Name </b></label>
    <input class="editinput w3-input w3-border form-bg w3-text" type="text" id="firstname" name="firstname" placeholder="First Name" value="${firstname}" required pattern="^[a-zA-Z0-9_ ]+$" data-parsley-maxlength="50"></p>
    <p>     
    <label class="imp-text"><b> Last Name </b></label>
    <input class="editinput w3-input w3-border form-bg w3-text" type="text" id="lastname" name="lastname" placeholder="Last Name" value="${lastname}" required pattern="^[a-zA-Z0-9_ ]+$" data-parsley-maxlength="50"></p>
    <p>    
    <label class="imp-text"><b> Username </b></label>
    <input class="editinput w3-input w3-border form-bg w3-text" type="text" id="username" name="username" placeholder="Username" value="${username}" required pattern="^[a-zA-Z0-9_]+$"></p>
    <p>
    <p>
	<label class="imp-text"><b> Birthday </b></label>
	<input class="w3-input w3-border form-bg w3-text" type="date" id="birth" name="birth" value="${birth}" required data-parsley-min-age="16"></p>
    <input class="editinput w3-button w3-round-medium w3-theme" type="submit" name="submit" value="Update"></p>
</form>

<!-- Edit password form -->
<h2><b>Edit password</b></h2>
<hr>
<form id="${uid}" data-parsley-validate action="#" method="POST" class="editPwdForm">
	<p>
	<label class="imp-text"><b> Current Password </b></label>
	<input class="w3-input w3-border form-bg w3-text" type="password" id="pwd1" name="currentpwd" placeholder="Current Password" value="${currentpwd}" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"></p>
	<p>
	<label class="imp-text"><b> New Password </b></label>
	<input class="w3-input w3-border form-bg w3-text" type="password" id="pwd1" name="newpwd" placeholder="New Password" value="${newpwd}" required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"></p>
	<div>
	<p>
    <input class="editinput w3-button w3-round-medium w3-theme" type="submit" name="submit" value="Update">
    <span class="w3-text-green" style="display:none;" id="passwordUpdatedStatus"></span>
    </p>
    </div>
</form>

<!-- Edit profile image form -->
<h2><b>Edit profile image</b></h2>
<hr>
<form id="${uid}" class="uploadProfileImage" action = "UploadProfileImage" method = "post" enctype = "multipart/form-data">
     <label class="imp-text"><b> Profile Image </b></label>
     <br /><br />
     <label for="fileButton" class="w3-button w3-round-medium w3-theme">
    	Select file
	 </label>
	 <span>You must upload a .png file</span>
     <input id="fileButton" type="file" style="display:none" name="file" size = "50" />
     <br />
     <div style="margin-top: 25px; margin-bottom: 10px;">
     <input type="submit" class="w3-button w3-round-medium w3-theme" value="Upload File" />
     <span class="w3-text-green" style="display:none;" id="uploadedSuccessful"></span>
     </div>
 </form>

<c:if test="${isAdmin || isLoggedUser}">
 <button type="button" id="deleteAccount" class="w3-button w3-margin-bottom w3-round-medium w3-red"><i class="fa fa-warning"></i> &nbsp;Delete account</button>
</c:if>
</div>
