
<!-- 
/**
 * Author:Tamal Sen
 * Date:11/05/09
 * version:1.0
 *
 */-->


<!--setting pagetype -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--importing classes -->
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 
<%@ page import="java.lang.String" %>
<!--start of HTML form -->
<html>

<!--start of head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!--title to be displayed in title bar -->
<title>Agent Add Page</title>

<!--Including Stylesheet -->
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />


<!--Java Script coding -->
<script>
	<!--Java Script coding for form validation-->
	
	function validateForm1()
    {
  		if(document.getElementById("AID1").value=="")
		{
			alert("Enter Agent ID")
		}
		else if(document.getElementById("AID2").value=="")
		{
			alert("Enter Agent Name")
		}
		else if(document.getElementById("AID3").value=="")
		{
			alert("Enter Agent Location")
		}
		else if(document.getElementById("AID4").value=="")
		{
			alert("Enter Agent IP Address")
		}
	   	else
        {
           Agentadd.submit();
        }  
       
}
</script>

<!--end of head -->
</head>

<!--Start of Body -->
<body>
<!--To prevent page caching -->
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@page session="false"%>
	<%
		if (request.getSession(false) == null || !request.getSession().getAttribute("priv").equals("A"))
		response.sendRedirect("Logout.jsp");
	%>	
	<!--Agentadd Form Declaration -->
	
	<h2>AGENT ADMINISTRATION</h2>
	<hr>
	<br/>
	
	<!--Creating table for displaying fields -->
	<fieldset style="width:500px;" align="center"><legend>ADD AGENT FORM</legend>
	<form name="Agentadd" METHOD="POST" ACTION="AgentAddServlet">
	<table align="center" cellspacing="5" cellpadding="5" border="0">
		
		<!--TextBox for getting Agent ID -->
		<tr>
    		<td>Agent ID</td>      
    		<td><input type="text" class="text" name="yourid" id="AID1" SIZE=20 maxlength="10"><font color="#FF0000">*</font></td>
    	</tr>
    	
    	<!--TextBox for getting Agent name -->
    	<tr>
    		<td>Agent Name</td>    
    		<td><input type="text" class="text" name="yourname" id="AID2" SIZE=20 maxlength="30"><font color="#FF0000">*</font></td>
    	</tr>
    	
    	<!--TextBox for getting Agent Location -->
    	<tr>
    		<td>Agent Location</td>
    		<td> <input type="text" class="text" name="yourloc" id="AID3" SIZE=20 maxlength="20"><font color="#FF0000">*</font></td>
    	</tr>
    	
    	<!--TextBox for getting Agent IP Address -->
    	<tr>
    		<td>AgentIP Address</td>
    		<td><input type="text" class="text" name="yourip" id="AID4" SIZE=30 maxlength="15"><font color="#FF0000">*</font></td>
    	</tr>
    	
    	<!--MultiLine TextBox for getting user Comments -->
    	<tr>
    		<td>Comments</td>
    		<td><textarea class="text" name="yourcomments" rows="10" cols="24" maxlength="50"></textarea></td>
		</tr>
	</table>
	
	
	<table align="center" border="0">
		<tr><td colspan="2">
		<br><br><br><br>
		<!--For displaying success/error message -->
		<%
			if(request.getAttribute("success")=="success")
			{
				out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Agent Added Successfully</font>");
			}
			else if(request.getAttribute("error")!=null)
			{
				if(request.getAttribute("error").equals("1"))
				{
					out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Agent ID already exists</font>");
				}
				else if(request.getAttribute("error").equals("17002"))
				{
					out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Could not connect to the database, please try after sometime</font>");
				}
				else
				{
					out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Cannot Add the Agent</font>");
				}
			}
			
		%></td>
		</tr><tr>
		
		<!--For displaying Submit and reset buttons -->
		<td><input type="BUTTON" class="btn1" name="myButton"  value="Submit" onclick="validateForm1()"></td>
		<td><input type="RESET" class="btn1" name="myButton1" value="Reset"></td>
		</tr>
	</table>
	</form>
</fieldset>
	
	<!--closing the Agentadd Form -->
	
	
<!--Closing Body -->	
</body>

<!--Closing HTML Form-->
</html>