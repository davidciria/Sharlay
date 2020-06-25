<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="userfound" items="${searchResult}">       
	 <div id="${userfound.uid}" class="w3-container w3-card w3-white w3-round w3-margin w3-animate-opacity"><br>
	   <img src="ProfileImages/${userfound.uid}.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px" onerror="javascript:this.src='ProfileImages/default.png'">
	   <h4 class="uVw" style="text-decoration:none" onmouseover="style='text-decoration:underline; cursor:pointer'" onmouseout="style='text-decoration:none'"> ${userfound.username} </h4><br>
	 </div>
</c:forEach>

<c:if test="${searchResult.size() == 0}">
<div id="${userfound.uid}" class="w3-container w3-card w3-white w3-round w3-margin w3-animate-opacity">
<h4>No results found</h4>
</div>
</c:if>