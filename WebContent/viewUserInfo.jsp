<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="w3-card w3-round w3-white">
  <div class="w3-container">
   <h4 class="w3-center"><i>My Profile</i></h4>
   <p class="w3-center"><img src="w3images/avatar3.png" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
   <hr>
   <p id="uid"><i class="fa fa-id-card fa-fw w3-margin-right w3-text-theme"></i> ${user.mail} </p>
   <p id="name"><i class="fa fa-id-badge fa-fw w3-margin-right w3-text-theme"></i> ${user.username} </p>
  </div>
</div>
<br>