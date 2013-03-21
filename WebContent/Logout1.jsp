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
//session.invalidate();
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<!--start of HTML form -->
<html>

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
<body bgcolor="#C6DEFF" onload="Login_go.submit()">
<%@page session="false"%>
	<%
	HttpSession sess=request.getSession(false);	
		if (sess != null){
			sess.setMaxInactiveInterval(1);
			sess.invalidate();
		}
	%>	

<!--Disabling backspace button -->
<body onKeydown="if (event.keyCode == 8){return false;}"> 
<body oncontextmenu="return false"> 

	<!--Login_go form declaration -->
	<form name="Login_go" action="Login.jsp">
	<!--closing the Login_go Form -->	
	</form>
			
	
<!--Closing Body -->
</body>

<!--Closing HTML Form-->
</html>