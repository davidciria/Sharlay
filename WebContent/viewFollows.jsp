<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="u" items="${users}">       
 <div id="${u.uid}" class="sU w3-container w3-card w3-white w3-round w3-margin w3-animate-opacity"><br>
   <img src="w3images/avatar2.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
   <h4> ${u.username} </h4><br>
   <button type="button" class="uF w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-trash"></i> &nbsp;Unfollow</button> 
 </div>
</c:forEach>