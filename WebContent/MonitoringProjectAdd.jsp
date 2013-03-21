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
<%@ page
import="java.util.*,java.sql.*,loadele.ListElements"
%>

<!--start of HTML form -->
<html>

<!--start of head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!--title to be displayed in title bar -->
<title>Monitoring Project Add Page</title>

<!--including stylesheet in the page-->
<link href="calender/rfnet.css" rel="stylesheet" type="text/css">

<!--Including Stylesheet -->
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />

<!--including javascript for calendar type -->
<script type="text/javascript" src="calender/datetimepicker_css.js"></script>

<!--including Java Script for select box exchange of date,selecting all options of list box,validating the form -->
<script type="text/javascript" src="js/project_validate.js">
</script>




<!--end of head -->
</head>


<!--Start of Body -->
<body>
<%@page session="false"%>
	<%
		if (request.getSession(false) == null|| !request.getSession().getAttribute("priv").equals("A"))
		response.sendRedirect("Logout.jsp");
	%>
	<h2>PROJECT ADMINISTRATION</h2>
	<hr>
	<!--Project form Declaration -->
	<fieldset style="width:600px;" align="center"><legend>ADD NEW PROJECT</legend>
	<form name="Project" method="post" action="\EURTF\MonitoringProjectAddServlet">
	
	
	<!--Creating table for displaying fields -->
	<table align="center">

		<!--Text Box for getting Project ID -->
		<tr>
			<td>Monitoring Project ID :</td>
			<td><INPUT type="text" class="text" NAME="ProjID" SIZE=20  maxlength="10"><font color="#FF0000">*</font></td>
		</tr>
		
		<tr>
			<td>&nbsp</td>
		</tr>
		
		<!--Text Box for getting Project name -->
		<tr>
			<td>Monitoring Project Name :</td>
			<td><INPUT type="text" class="text" NAME="ProjName" SIZE=20  maxlength="30"><font color="#FF0000">*</font></td>
		</tr>
		
		<tr>
			<td>&nbsp</td>
		</tr>
		
		<!--Text Box for getting Start Date & Time, a calendar is displayed nearby -->
		<tr>
			<td>Start Date & Start Time :</td>
			<td><INPUT type="text" class="text" NAME="Sdt" ></td>
			<td><a href="javascript: NewCssCal('Sdt','ddmmyyyy','dropdown',true,24,false)">
			<img src="calender/cal.gif" width="16" height="16" alt="Pick a date"></a><font color="#FF0000">*</font></td>
		</tr>
		
		<tr>
			<td>&nbsp</td>	
		</tr>
		
		<!--Text Box for getting end Date & Time, a calendar is displayed nearby -->
		<tr>
			<td>End Date & End Time :</td>
			<td><INPUT type="text" class="text" NAME="Edt"  ></td>
			<td><a href="javascript: NewCssCal('Edt','ddmmyyyy','dropdown',true,24,false)">
			<img src="calender/cal.gif" width="16" height="16" alt="Pick a date"></a><font color="#FF0000">*</font></td>
		</tr>
		
		<tr>
			<td>&nbsp</td>
		</tr>
		
		<!--Text Box for getting Status of Project, by default it is "In Progress" -->
		<tr>
			<td>Status :</td>
			<td><INPUT type="text" class="text" NAME="Status" VALUE="In Progress"  maxlength="20"><font color="#FF0000">*</font></td>
		</tr>
		
		<tr>
			<td>&nbsp</td>
		</tr>

		<!--Text Box for getting Description about Project -->
		<tr>
			<td>Description :</td>
			<td><TEXTAREA NAME="desc" class="text" ROWS=5 COLS=18  maxlength="50"></TEXTAREA></td>
		</tr>
		
		<tr>
			<td>&nbsp</td>
		</tr>
		
		<!--List Box for Displaying available agents, autopopulated thorugh a bean -->
		<tr>
			<td>Select Required Agents:</td>
			<td ><SELECT NAME="ReqAgents" multiple="multiple" SIZE=10 style="width:100px">
			<%
				//calling a function to fetch data
				ListElements L=new ListElements();
				ArrayList A=L.load("ReqAgents");
				for(int i=0;i<A.size();i++)
				{	//inserting agents available into list
					out.println("<OPTION VALUE=\""+A.get(i)+"\">"+A.get(i)+"</OPTION>");
				}
				L=null;
				A=null;
			%>
			</SELECT></td>
			
			<!--Button for moving data into Selected agents -->
			<td><INPUT TYPE="BUTTON" NAME="btnsel" OnClick="forward()" VALUE="&gt&gt" class="text">
			
			<!--Button for moving data from Selected agents -->
			<br><br><INPUT TYPE="BUTTON" NAME="btnrem" OnClick="reverse()" VALUE="&lt&lt" class="text"></td>
			
			<!--ListBox to hold Selected agents -->
			<td ><SELECT NAME="SelAgents" multiple="multiple" SIZE=10 style="width:100px"></SELECT></td>
		</tr>
	</table>


	<table align="center">
		<tr>
			<td>&nbsp</td>
		</tr>
		
		<tr>
			<td>&nbsp</td>
		</tr>
		
		<tr><td colspan="3" align="center">
		<!--For displaying success/error message -->
		<%
			if(request.getAttribute("success")=="success")
			{
				out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Project Added Successfully</font>");
			}
			else if(request.getAttribute("error")!=null)
			{
				if(request.getAttribute("error").equals("1"))
				{
					out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Project ID already exists</font>");
				}
				if(request.getAttribute("error").equals("17002"))
				{
					out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Could not connect to the database, please try after sometime</font>");
				}
				else
				{
					out.println("<font size=2 face=\"Verdana\" color=\"#C11B17\">Cannot Add the Project</font>");
				}
			}
			
		%>
		</td>
		</tr>
		
		<tr>
			<!--For displaying submit and reset buttons -->
			<td>
			<td><INPUT TYPE="BUTTON" name="sub" class="btn1" VALUE="SUBMIT" OnClick="javascript : validate()"></td>
			<td><INPUT TYPE="RESET" class="btn1" VALUE="RESET"></td>
		</tr>
	</table>

	<!--closing the Project Add Form -->
	</form>
</fieldset>
<!--Closing Body -->
</body>

<!--Closing HTML Form-->
</html>