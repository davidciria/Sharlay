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
			console.log(i, instance[i].isValid());
			if($(".editinput").eq(i).val() == ""){
				$(".editinput").eq(i).attr("class", "w3-input w3-border w3-light-grey");
			}else{
				if(instance[i].isValid()) $(".editinput").eq(i).attr("class", "w3-input w3-border w3-border-green w3-hover-border-green w3-light-grey");
				else $(".editinput").eq(i).attr("class", "w3-input w3-border w3-border-red w3-light-grey");
			}
		  }
	  });
	  
	$(".editForm").submit( function(event) {
		event.preventDefault();
		var uid = $(this).attr("id");
		var formParams = $(this).serializeArray();
		var firstname = "${editUser.firstname}";
		var lastname = "${editUser.lastname}";
		var username = "${editUser.username}";
		var newfirstname = null;
		var newlastname = null;
		var newusername = null;
		if(firstname != formParams[0].value) newfirstname = formParams[0].value;
		if(lastname != formParams[1].value) newlastname = formParams[1].value;
		if(username != formParams[2].value) newusername = formParams[2].value;
		$('#dtweets').load("EditProfileForm",{firstname: newfirstname, lastname: newlastname, username: newusername, uid: "${uid}",firstCall: false}, function(data){
			$("#duser").load( "GetUserInfo", { uid:  uid } ,function() {});
		});
	});
	
	$(".uploadProfileImage").submit(function(evt){	 
	      evt.preventDefault();
	      var formData = new FormData($(this)[0]);
	      formData.append("uid", $(this).attr("id"));
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
	         alert(response);
	         //Show success updating profile image.
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

<div id="confirmDialog">Are you sure?</div>

<div class="w3-container w3-card w3-white w3-round w3-margin w3-animate-opacity">

<form id="${uid}" data-parsley-validate action="#" method="POST" class="editForm">
	<p>      
    <label class="w3-text-purple"><b> First Name </b></label>
    <input class="editinput w3-input w3-border w3-light-grey" type="text" id="firstname" name="firstname" placeholder="First Name" value="${firstname}" required pattern="^[a-zA-Z0-9_ ]+$" data-parsley-maxlength="50"></p>
    <p>     
    <label class="w3-text-purple"><b> Last Name </b></label>
    <input class="editinput w3-input w3-border w3-light-grey" type="text" id="lastname" name="lastname" placeholder="Last Name" value="${lastname}" required pattern="^[a-zA-Z0-9_ ]+$" data-parsley-maxlength="50"></p>
    <p>    
    <label class="w3-text-purple"><b> Username </b></label>
    <input class="editinput w3-input w3-border w3-light-grey" type="text" id="username" name="username" placeholder="Username" value="${username}" required pattern="^[a-zA-Z0-9_]+$"></p>
    <p>
    <input class="editinput w3-button w3-round-medium w3-purple" type="submit" name="submit" value="Update"></p>
</form>

<form id="${uid}" class="uploadProfileImage" action = "UploadProfileImage" method = "post" enctype = "multipart/form-data">
     <input type="file" name="file" size = "50" />
     <br />
     <input type="submit" value="Upload File" />
 </form>

<c:if test="${isAdmin}">
 <button type="button" id="deleteAccount" class="w3-button w3-margin-bottom w3-round-medium w3-red"><i class="fa fa-warning"></i> &nbsp;Delete account</button>
</c:if>
</div>
