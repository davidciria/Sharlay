<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${viewuser.uid == user.uid}">
	<div class="w3-card w3-round w3-white">
	  <div class="w3-container">
	   <h4 class="w3-center"> ${user.firstname} ${user.lastname}
	   	<button type="button" class="eP w3-button w3-tiny w3-padding-small w3-theme"><i class="fa fa-pencil"></i></button> 
	   </h4>
	   <p class="w3-center"><img src="w3images/avatar3.png" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
	   <hr>
	   <p id="name"><i class="fa fa-user fa-fw w3-margin-right w3-text-theme"></i> ${user.username} </p>
	   <p id="uid"><i class="fa fa-envelope fa-fw w3-margin-right w3-text-theme"></i> ${user.mail} </p>
	  </div>
	</div>
	<br>
</c:if>
<c:if test="${viewuser.uid != user.uid}">
	<div class="w3-card w3-round w3-white"  id="${viewuser.uid}">
	  <div class="w3-container">
	   <h4 class="w3-center"> ${viewuser.firstname} ${viewuser.lastname}</h4>
	   <p class="w3-center"><img src="w3images/avatar3.png" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
	   <hr>
	   <c:if test="${!isFollowed}">
	   	<button type="button" class="fU w3-button w3-green w3-margin-bottom"><i class="fa fa-plus-circle"></i>&nbsp;Follow</button>
	   </c:if>
	   <c:if test="${isFollowed}">
	   	<button type="button" class="uU w3-button w3-red w3-margin-bottom"><i class="fa fa-minus-circle"></i>&nbsp;Unfollow</button>
	   </c:if>
	   <p id="name"><i class="fa fa-user fa-fw w3-margin-right w3-text-theme"></i> ${viewuser.username} </p>
	   <p id="uid"><i class="fa fa-envelope fa-fw w3-margin-right w3-text-theme"></i> ${viewuser.mail} </p>
	  </div>
	</div>
	<br>
</c:if>