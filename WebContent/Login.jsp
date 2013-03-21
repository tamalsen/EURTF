<!-- 
/**
 * Author:O.K.Siva Murugan
 * Date:09/05/09
 * version:1.0
 *
 */-->

<!--setting pagetype -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!--start of HTML form -->
<html>

<!--start of head -->
<head>

<!--title to be displayed in title bar -->
<title>Login Page</title>

<!--Including Stylesheet -->
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />

<!--Java Script coding -->
<script>

<!--Java Script coding for form validation -->

	function validate()
	{	
		if(document.getElementById("name").value=="")
		{
			alert('Enter user name')
		}
		else if(document.getElementById("pass").value=="")
		{
			alert('Enter password')
		}
		else
		{
			LoginForm.submit();
		}
	}
	
</script>

<!--end of head -->
</head>

<!--Start of Body -->
<body class="dont" onload="document.getElementById('name').focus()">
<%@page session="false"%>
<%@ page import="java.io.*" %>
<%
/*File f=new File("./");
System.out.println("FILE PATH1::::"+f.getAbsolutePath());
*/
HttpSession sess=request.getSession(false);
if(sess != null)
{	out.println("<b>SESSION::</b>"+sess.getId());
	sess.invalidate();

}
%>	
<h2>END USER RESPONSE TIME FRAMEWORK</h2>
<hr>
<br><br><br><br><br><br>
	<!--Login Form Declaration -->
	<fieldset class="filter" style="width:500px;font-size:15px;letter-spacing:0px;" align="left"><legend>Welcome to EURTF</legend>
	<span style="color:#000000;">
	<br>
	<u>Recommendations for running this application properly:</u><br>
	<b>Screen Resolutions:</b> 1280x1024<br>
<b>Browser:</b> IE 6.0 or above<br>
	<b>Internet Explorer Setting:</b><br>1. Go to <i>Tools->Internet Options->Settings. </i>
	 In "<i>Check for newer versions of stored pages:</i>" Enable the option "<i>Every visit to the page</i>".<br>
2. Turn off the popup blocker.
<br>
</span>
	</fieldset>
	<fieldset class="filter" style="width:400px;" align="right"><legend>LOGIN</legend>
	<form name="LoginForm" action="Authenticate" method="post">
		
	
	<!--Creating table for displaying fields -->
	<table cellspacing="5" cellpadding=5 border="0" align="center">

		<!--TextBox for getting user name -->
		<tr>
			<td>Enter User Name :</td>
			<td><input type="text" class="text" name="uname" id="name" ></td>
		</tr>
		
		<!--TextBox for getting user password -->
		<tr>
			<td>Enter Password &nbsp&nbsp:</td>
			<td><input type="password" name="password" id="pass"  class="text" onKeydown="if (event.keyCode == 13){validate()}"></td>
		</tr>
		<tr>
		<td colspan="2">
		<%
		if(request.getAttribute("error")=="error")
		{
			out.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Invalid username and password</font>");
		}
		%>
		</td>
		</tr>
	
	
		<tr>
			<td><input class="btn1" type="button" value="LOGIN" onclick="validate()"></td>
			<td><input class="btn1" type="reset" value="CANCEL"></td>
		</tr>
	</table>
	
	<!--closing the Login Form -->
	</form>
	</fieldset>
<!--Closing Body -->
</body>

<!--Closing HTML Form-->
</html>