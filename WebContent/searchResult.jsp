<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="userfound" items="${searchResult}">       
	 <div id="${userfound.uid}" class="w3-container w3-card w3-white w3-round w3-margin w3-animate-opacity"><br>
	   <img src="w3images/avatar2.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
	   <h4> ${userfound.username} </h4><br>
	   <hr class="w3-clear">
	 </div>
</c:forEach>