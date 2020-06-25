<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="u" items="${users}">       
 <div id="${u.uid}" class="sU w3-container w3-card w3-white w3-round w3-margin w3-animate-opacity"><br>
   <img src="ProfileImages/${u.uid}.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px; margin-bottom: 10px" onerror="javascript:this.src='ProfileImages/default.png'">
   <h4 style="text-decoration:none" onmouseover="style='text-decoration:underline; cursor:pointer'" onmouseout="style='text-decoration:none'"> ${u.username} </h4>
 </div>
</c:forEach>