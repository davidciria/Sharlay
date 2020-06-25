<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- style to create vertical line -->
<style> 
	.line-in-middle {
	   background-image: linear-gradient(#FFF, #FFF);
			background-size: 0.5px 100%;
			background-repeat: no-repeat;
			background-position: center center;
			opacity: 0.6;
	}
	.splitscreen {
    	display:flex;
	}
	.splitscreen .left {
	    flex: 0.45;
	    margin-top: -30px;
	    margin-bottom: -5px;
	}.splitscreen .center {
	    flex: 0.1;
	    margin-top: -20px;
	}
	.splitscreen .right {
	    flex: 0.45;
	    margin-top: -30px;
	    margin-bottom: -5px;
	} 
</style> 

<c:if test="${viewuser.uid == user.uid}">
	<div class="w3-card w3-round w3-text" id="${user.uid}">
	  <div class="w3-container">
	   <h4 class="w3-center"> ${user.firstname} ${user.lastname}
	   	<button type="button" class="eP w3-button w3-tiny w3-padding-small w3-theme w3-round-xxlarge" style="margin-top: -5px"><i class="fa fa-pencil"></i></button> 
	   </h4>
	   <p class="w3-center"><img src="ProfileImages/${user.uid}.png" id="profileImage" class="w3-circle" style="height:106px;width:106px" alt="Avatar" onerror="javascript:this.src='ProfileImages/default.png'"></p>
	   <hr>
	   <p id="name"><i class="fa fa-user fa-fw w3-margin-right imp-text"></i> ${user.username} </p>
	   <p id="birthday"><i class="fa fa-birthday-cake fa-fw w3-margin-right imp-text"></i> ${user.birth} </p>
	   <hr>
	   <div class="splitscreen">
		    <div class="left">
		        <p id="followingtxt" class="vF w3-center imp-text" style="text-decoration:none" onmouseover="style='text-decoration:underline; cursor:pointer'" onmouseout="style='text-decoration:none'"><b>Following</b> </p>
		        <p id="followingnum" class="w3-center" style="margin-top: -5px;"> ${user.following} </p>
		    </div>
		        <div class="center line-in-middle"></div>
		    <div class="right">
		      	<p id="followerstxt" class="vS w3-center imp-text" style="text-decoration:none" onmouseover="style='text-decoration:underline; cursor:pointer'" onmouseout="style='text-decoration:none'"><b>Followers</b> </p>
		      	<p id="followersnum" class="w3-center" style="margin-top: -5px;"> ${user.followers} </p>
		    </div>
		</div>
	  </div>
	</div>
	<br>
</c:if>
<c:if test="${viewuser.uid != user.uid}">
	<div class="w3-card w3-round w3-text"  id="${viewuser.uid}">
	  <div class="w3-container">
	   <h4 class="w3-center"> ${viewuser.firstname} ${viewuser.lastname}
	   <c:if test="${user.isAdmin}">
	   <button type="button" class="eP w3-button w3-tiny w3-padding-small w3-theme w3-round-xxlarge" style="margin-top: -5px"><i class="fa fa-pencil"></i></button> 
	   </c:if>
	   </h4>
	   <p class="w3-center"><img src="ProfileImages/${viewuser.uid}.png" id="myImage" class="w3-circle" style="height:106px;width:106px" alt="Avatar" onerror="javascript:this.src='ProfileImages/default.png'"></p>
	   <hr>
	   <c:if test="${!isFollowed}">
	   	<button type="button" class="fU w3-button w3-green w3-margin-bottom w3-round-medium"><i class="fa fa-plus-circle"></i>&nbsp;Follow</button>
	   </c:if>
	   <c:if test="${isFollowed}">
	   	<button type="button" class="uU w3-button w3-red w3-margin-bottom w3-round-medium"><i class="fa fa-minus-circle"></i>&nbsp;Unfollow</button>
	   </c:if>
	   <p id="name"><i class="fa fa-user fa-fw w3-margin-right imp-text"></i> ${viewuser.username} </p>
		<p id="birthday"><i class="fa fa-birthday-cake fa-fw w3-margin-right imp-text"></i> ${viewuser.birth} </p>
	   <hr>
	   <div class="splitscreen">
		    <div class="left">
		        <p id="followingtxt" class="vF w3-center imp-text" style="text-decoration:none" onmouseover="style='text-decoration:underline; cursor:pointer'" onmouseout="style='text-decoration:none'"><b>Following</b> </p>
		        <p id="followingnum" class="w3-center" style="margin-top: -5px;"> ${viewuser.following} </p>
		    </div>
		        <div class="center line-in-middle"></div>
		    <div class="right">
		      	<p id="followerstxt" class="vS w3-center imp-text" style="text-decoration:none" onmouseover="style='text-decoration:underline; cursor:pointer'" onmouseout="style='text-decoration:none'"><b>Followers</b> </p>
		      	<p id="followersnum" class="w3-center" style="margin-top: -5px;"> ${viewuser.followers} </p>
		    </div>
		</div>
	  </div>
	</div>
	<br>
</c:if>