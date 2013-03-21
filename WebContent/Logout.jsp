<!-- 
/**
 * Author:O.K.Siva Murugan
 * Date:14/05/09
 * version:1.0
 *
 */-->
 
 <!--setting pagetype -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page isErrorPage="true" %>

<!--To prevent page caching -->
<%

response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<!--start of HTML form -->
<html>
<%@page session="false"%>
	<%
		HttpSession sess=request.getSession(false);	
		if (sess != null){
			sess.invalidate();
		}
			
			
	%>	
<!--start of head -->
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!--title to be displayed in title bar -->
<title>Invalid User</title>

<!--Including Stylesheet -->
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />

<!--Java Script coding -->
<script>
if (history.length >0)
history.go(+1);
javascript:window.history.forward(1);
</script>

<!--end of head -->
</head>

<!--Start of Body -->
<body bgcolor="#C6DEFF" onload="window.location=Logout.jsp">
<!--Disabling backspace button -->
<body onKeydown="if (event.keyCode == 8){return false;}"> 
<body oncontextmenu="return false"> 
	<font size=4 face="Verdana" color="#7E2217">

	<h2>&nbsp</h2>
	<h2>&nbsp</h2>
	<h2>&nbsp</h2>
	<h2 align="center">You have not logged in</h2>
	</font>
	
	<hr>
	
	<h5 align="center">To go back to Login page click login page button</h5>

	<!--Login_go form declaration -->
	<form name="Login_go" action="Login.jsp">
	
		<!--creating a button for submitting form-->	
		<div align="center">
		<table>
		<td align="center">
		<input type="submit" class="btn1" name="button" value="Login Page">
		</td>
		</table>
		</div>
			
	<!--closing the Login_go Form -->	
	</form>
			
	
<!--Closing Body -->
</body>

<!--Closing HTML Form-->
</html>