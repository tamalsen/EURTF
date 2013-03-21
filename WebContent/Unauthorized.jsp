<!-- 
/**
 * Author:O.K.Siva Murugan
 * Date:15/05/09
 * version:1.0
 *
 */-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page session="false"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Unauthorized user</title>
</head>
<body bgcolor="#C6DEFF" onload="window.location=Logout.jsp">
<body onKeydown="if (event.keyCode == 8){return false;}"> 
<body oncontextmenu="return false"> 
<font size=4 face="Verdana" color="#7E2217">

<h2>&nbsp</h2>
<h2>&nbsp</h2>
<h2>&nbsp</h2>
<h2 align="center">You are not authorized to view this page</h2>
</font>
<hr>
<h5 align="center">To go to Login page click login page button</h5>
<form name="f2" action="Login.jsp">
<div align="center">
<table>
<td align="center">
<input type="submit" class="btn1" name="button" value="Login Page">
</td>
</table>
</div>
</form>
</body>
</html>