<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<c:forEach var="t" items="${tweets}">       
	 <div id="${t.tweetid}" class="w3-container w3-card w3-white w3-round w3-margin w3-animate-opacity"><br>
	   <img src="w3images/avatar2.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
	   <span class="w3-right w3-opacity"> ${t.createdAt} </span>
	   <h4> ${t.username} </h4><br>
	   <hr class="w3-clear" style="margin-top: -5px">
	   <p id="tweetText"> ${t.text} </p>
	   <c:if test="${t.isLiked}">
	   <button type="button" class="dlT w3-button w3-theme-d1 w3-margin-bottom w3-round-medium"><i class="fa fa-thumbs-up"></i> &nbsp;Like</button>
	   </c:if>
	   <c:if test="${!t.isLiked}">
	   <button type="button" class="lT w3-button w3-theme-l5 w3-margin-bottom w3-round-medium"><i class="fa fa-thumbs-up"></i> &nbsp;Like</button>
	   </c:if>
	   <c:if test="${viewuser.uid == user.uid}">
	   		<button type="button" class="dT w3-button w3-theme-d1 w3-margin-bottom w3-right"><i class="fa fa-trash"></i></button>
	   		<button type="button" class="eT w3-button w3-theme-d1 w3-margin-bottom w3-right"><i class="fa fa-pencil"></i></button>  
	   </c:if>
	 </div>
	</c:forEach>