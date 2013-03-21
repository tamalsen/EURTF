<!-- 
/**
 * Author:Tamal Sen
 * Date:15/05/09
 * version:1.0
 *
 */-->

<!--setting pagetype -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--importing classes -->
<%@ page
import="java.util.*,java.sql.*,jdbc.*,loadele.ListElements"
%>
<!--start of HTML form -->
<html>

<!--start of head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!--title to be displayed in title bar -->
<title>Monitoring Project Edit Page</title>

<!--including stylesheet in the page-->
<link href="calender/rfnet.css" rel="stylesheet" type="text/css">

<!--Including Stylesheet -->
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />

<!--including javascript for calendar type -->
<script type="text/javascript" src="calender/datetimepicker_css.js">
</script>

<!--including Java Script for select box exchange of date,selecting all options of list box,validating the form -->
<script type="text/javascript" src="js/project_validate.js">
</script>


<!--end of head -->
</head>

<!--Start of Body -->
<body >
<%@page session="false"%>
	<%
		if (request.getSession(false) == null|| !request.getSession().getAttribute("priv").equals("A"))
		response.sendRedirect("Logout.jsp");
	%>
	<h2>PROJECT ADMINISTRATION</h2>
	<hr>
	<!--Projectedit form Declaration -->

	<fieldset style="width:600px;" align="center"><legend>EDIT PROJECT</legend>
	<form name="Project" method="post" action="\EURTF\MonitoringProjectEditServlet">

	<%! String str; %>
 	<%
  		str=request.getParameter("ProjID");
 		Connection con=null;
		ConnectionPool connPool = null;
		Statement st=null;
		ResultSet rs=null;
  		try
  		{
	    	//creating connection
			connPool=(ConnectionPool)application.getAttribute("connPool");
			con=connPool.getConnection();

			st=con.createStatement();
			
			//retreiving the details of selected agentid
			rs=st.executeQuery("select proj_id,proj_name,DATE_FORMAT(start_date,'%d-%m-%y %H:%i:%S'),DATE_FORMAT(end_date,'%d-%m-%y %H:%i:%S'),status,description from eurtf_monitoring_projects where proj_id='"+str+"'");
			response.setContentType("text/html");
			rs.next();
  	%>
	
	<!--Creating table for displaying retrieved fields -->
	<table>
	
		<tr>
			<td>&nbsp</td>
		</tr>
	
		<!--TextBox for getting Project ID in hidden field -->	
		<tr>
			<td><input type="text" class="text" name="Prid" value="<%=rs.getString(1)%>" readonly="true" size="20"  style="display:none";></td>
		</tr>
	
		<!--TextBox for getting Project ID to be updated -->
		<tr>
			<td>Monitoring Project ID :</td>
			<td><INPUT type="text" class="text" NAME="ProjID" value="<%=rs.getString(1)%>" SIZE=20 maxlength="10"><font color="#FF0000">*</font></td>
		</tr>
	
		<tr>
			<td>&nbsp</td>
		</tr>
	
		<!--TextBox for getting Project Name to be updated -->
		<tr>
			<td>Monitoring Project Name :</td>
			<td><INPUT type="text" class="text" NAME="ProjName" value="<%=rs.getString(2)%>" SIZE=20 maxlength="30"><font color="#FF0000">*</font></td>
		</tr>
	
		<tr>
			<td>&nbsp</td>
		</tr>

		<!--Text Box for getting Start Date & Time to be updated, a calendar is displayed nearby -->
		<tr>
			<td>Monitoring Project Start Date & Start Time :</td>
			<td><INPUT type="text" class="text" NAME="Sdt" value="<%=rs.getString(3)%>"></td>
			<td><a href="javascript: NewCssCal('Sdt','ddmmyyyy','dropdown',true,24,false)">
			<img src="calender/cal.gif" width="16" height="16" alt="Pick a date"></a><font color="#FF0000">*</font></td>
		</tr>
	
		<tr>
			<td>&nbsp</td>
		</tr>

		<!--Text Box for getting Project Date & Time to be updated, a calendar is displayed nearby -->
		<tr>
			<td>Monitoring Project End Date & End Time :</td>
			<td><INPUT type="text" class="text" NAME="Edt" value="<%=rs.getString(4)%>"></td>
			<td><a href="javascript: NewCssCal('Edt','ddmmyyyy','dropdown',true,24,false)">
			<img src="calender/cal.gif" width="16" height="16" alt="Pick a date"></a><font color="#FF0000">*</font></td>
		</tr>
		
		<tr>
			<td>&nbsp</td>
		</tr>
	
		<!--TextBox for getting status to be updated -->
		<tr>
			<td>Status :<font size="2" color="red">(enter <b>"Stopped"</b> if project is completed)</font></td>
			<td><INPUT type="text" class="text" NAME="Status" value="<%=rs.getString(5)%>" maxlength="20"><font color="#FF0000">*</font></td>
		</tr>
	
		<tr>
			<td>&nbsp</td>
		</tr>
	
		<!--TextBox for getting Description to be updated -->
		<tr>
			<td>Description :</td>
			<td><TEXTAREA class="text" NAME="desc"  maxlength="50" ROWS=5 COLS=18><%=rs.getString(6)%></TEXTAREA></td>
		</tr>
	
		<tr>
			<td>&nbsp</td>
		</tr>
	
		<!--List Box for Displaying available agents, autopopulated thorugh a bean -->
		<tr>
			<td>Select Required Agents:</td>
			<td><SELECT NAME="ReqAgents" multiple="multiple" SIZE=10 style="width:100px">
			<%
				//calling a function to fetch data
				ListElements L=new ListElements();
				ArrayList A=L.load("ReqAgents");
				for(int i=0;i<A.size();i++)
				{
					//inserting agents available into list
					out.println("<OPTION VALUE=\""+A.get(i)+"\">"+A.get(i)+"</OPTION>");
				}

			%>
			</SELECT></td>
		
			<!--Button for moving data into Selected agents -->
			<td><INPUT TYPE="BUTTON" NAME="btnsel" OnClick="forward()" VALUE="&gt&gt" class="text">
		
			<!--Button for moving data from Selected agents -->
			<br><br><INPUT TYPE="BUTTON" NAME="btnrem" OnClick="reverse()" VALUE="&lt&lt" class="text"></td>
	
			<!--ListBox that holds agents for this project -->
			<td ><SELECT NAME="SelAgents" multiple="multiple" SIZE=10 style="width:100px">
			<%
				//calling a function to fetch data
				L=new ListElements();
				A=L.load(str);

				for(int i=0;i<A.size();i++)
				{
					//inserting agents available into list
					out.println("<OPTION VALUE=\""+A.get(i)+"\">"+A.get(i)+"</OPTION>");
				}
				L=null;
				A=null;
			%>
			</SELECT></td>
		
		</tr>
	</table>

	<!--Table For displaying update button -->
	<table align="center">
		<tr>
		<td>&nbsp</td>
		</tr>
		
		<tr>
			<td>&nbsp</td>
		</tr>

		<tr>
		<td>
			<td><INPUT TYPE="button"  class="btn1" VALUE="UPDATE" OnClick="validate()">&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="button"  class="btn1" VALUE="CANCEL" OnClick="window.location='MonitoringProjectView.jsp'"></td>
 		<%
 		}
  		finally
  		{
  			try
  			{
  				connPool.free(con);
  				rs.close();
  				st.close();
  			}
  			catch(Exception e){}
	  
		}
 		%>

		</tr>
	</table>

	<!--closing the Project Edit Form -->
	</form>
</fieldset>
<!--Closing Body -->
</body>

<!--Closing HTML Form-->
</html>