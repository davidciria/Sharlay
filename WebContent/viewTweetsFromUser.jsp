<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="t" items="${tweets}">       
 <div id="${t.tweetid}" class="w3-container w3-card w3-white w3-round w3-margin w3-animate-opacity"><br>
   <img src="w3images/avatar2.png" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
   <span class="w3-right w3-opacity"> ${t.createdAt} </span>
   <h4> ${t.tweetid} </h4><br>
   <hr class="w3-clear">
   <p> ${t.text} </p>
   <button type="button" class="lT w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i> &nbsp;Like</button>
   <button type="button" class="dT w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-trash"></i> &nbsp;Delete</button> 
 </div>
</c:forEach>
