<!-- 
/**
 * Author:O.K.Siva Murugan
 * Date:11/05/09
 * version:1.0
 *
 * Author:O.K.Siva Murugan
 * Date:14/05/09
 * version:1.1
 */-->

<!--setting pagetype -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!--importing class -->
<%@ page import="java.util.*,java.sql.*,le.LoadElement"%>
<%@page session="false"%>
<!--To prevent page caching -->
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--start of HTML form -->
<html>

<!--start of head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!--title to be displayed in title bar -->
<title>PageTestParser</title>

<!--Java Script coding -->
<script>

	function apagent()
	{
		var a=document.getElementById("Project").value
		if(a=="")
		{
			alert("choose a valid project");
		}
		else
		{
			newwindow=window.open("LoadAgent?proj_name="+a,'Agents','height=210,width=150,scrollbars=yes');
			newwindow.focus();
		}
	}




<!--Java Script coding for form validation-->



	function validate()
	{
		if(document.getElementById("myFile").value=="")
		{
			alert('Select a Data file')
		}
		else if(document.getElementById("myFile").value.lastIndexOf(".txt")==-1) {
			   alert("Upload Only .txt file for DATA FILE..!");
		}
		else if(document.getElementById("myFile1").value=="")
		{
			alert('Select a Image file')
		}
		else if(document.getElementById("myFile1").value.lastIndexOf(".png")==-1) {
			   alert("Upload Only .png file for IMAGE FILE..!");
		}

		else if(document.getElementById("Agent").value=="")
		{
			alert('Select an Agent')
		}
		else if(document.getElementById("Project").value=="")
		{
			alert('Select an Project')
		}
		else if(document.getElementById("TransName").value=="")
		{
			alert('Enter a Transaction Name')
		}
		else
		{
			UploadForm.submit();
		}
	}
	
</script>

<!--end of head -->
</head>

<!--Including Stylesheet -->
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />

<!--Start of Body -->
<body >

<%@page session="false"%>
<%
		if (request.getSession(false) == null|| !request.getSession().getAttribute("priv").equals("A"))
		response.sendRedirect("Logout.jsp");
	%>
<h2 align="center">PAGETEST PARSER</h2>
<hr>
<br>
<br>
<br>
<br>
<br>
<br>
<table width="100%"  align="right" border=0
	valign="middle">
	<tr>
		<td style="width: 500px;" align="justify" style="font-size:17px;color:#042007;" valign="top">
		<fieldset ><legend class="filter">PLEASE  NOTE...</legend><br><br>
		Upload an AOL pagetest log file and an waterfall image.
		Please make sure file is not corrupted and image is a real waterfall image that relates to the log file
		<br><br><br>
		</fieldset>
		</td>
		<td>
		<fieldset class="filter"><legend>UPLOAD FORM</legend> <!--Upload Form Declaration -->
		<form name="UploadForm" action="UploadServlet" method="post"
			enctype="multipart/form-data"><!--Creating table for displaying fields -->
		<table align="center">
			<tr>
				<td>Select Data file to be uploaded</td>
			</tr>

			<tr>
				<td><!--Creating File input type for getting pageload_details Data file name -->
				<input class="text" type="file" name="myFile" size='50' maxlength="100"><font
					color="#FF0000">*</font></td>
			</tr>

			<tr>
				<td>&nbsp</td>
			</tr>

			<tr>
				<td>Select Image file to be uploaded</td>
			</tr>

			<tr>
				<td><!--Creating File input type for getting waterfall image file name -->
				<input class="text" type="file" name="myFile1" size='50' maxlength="100"><font
					color="#FF0000">*</font></td>
			</tr>


			<tr>
				<td>&nbsp</td>
			</tr>

			<tr>
				<td>Select Project Name&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<!--Autopopulating Project name by getting agent names through a bean -->
				<SELECT NAME="project" id="Project" style="border:#009900;border-style:outset;">
					<OPTION VALUE="">Choose a Project Name... <%	
				//calling a function to fetch data
				LoadElement le=new LoadElement();
				ArrayList al=le.fetch();
				if(al!=null){
				for(int i=0;i<al.size();i++)
				{
					//inserting project names into list
					out.println("<OPTION VALUE="+al.get(i)+">"+al.get(i));
				}
				le=null;
				al=null;
				}
			%>
					
				</SELECT> <font color="#FF0000">*</font>
				<td>
			</tr>

			<tr>
				<td>&nbsp</td>
			</tr>

			<tr>
				<td>Select Agent
				Name&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <!--Autopopulating Agent name by getting agent names through a popup -->
				<input type="text" class="text" name="agent" id="Agent" size="25" onfocus="blur()"> <input
					type="button" onclick="apagent()" value="agents" class="text"> <font
					color="#FF0000">*</font></td>
			</tr>

			<tr>
				<td>&nbsp</td>
			</tr>



			<tr>
				<td>Enter Transaction Name&nbsp&nbsp <!--Text Box for getting transaction name -->
				<input type="text" class="text" name="TName" id="TransName" size="25"
					maxlength="20"><font color="#FF0000">*</font></td>
			</tr>

			<tr>
				<td>&nbsp</td>
			</tr>
		</table>

		<!--Table for displaying success/error message -->
		<table align="center">
			<tr><td colspan="">
				<%
			if(request.getAttribute("success")=="success")	
			{
				out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Uploaded Successfully</font>");
			}
			else if(request.getAttribute("error")=="error")
			{
				out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Cannot upload the file</font>");
			}
		%>
			</td></tr>
		</table>

		<!--creating a button for submitting form-->
		<table align="center">
			<tr>
				<td><input type="button" class="btn1" value="UPLOAD"
					onclick="validate()"></td>
			</tr>

		</table>

		<!--closing the Upload Form --></form>
		</fieldset>

		</td>
	</tr>
</table>

<!--Closing Body -->
</body>

<!--Closing HTML Form-->
</html>