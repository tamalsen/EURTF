<!-- 
/**
 * Author:Tamal Sen
 * Date:14/05/09
 * version:1.0
 *
 */-->

<!--setting pagetype -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--importing classes -->
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="jdbc.*"%>

<!--start of HTML form -->
<html>

<!--start of head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!--title to be displayed in title bar -->
<title>Monitoring Project Edit Page</title>
<!--Including Stylesheet -->
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
<script>
var selectedProjectId=0;
function startProject(){
	window.location="MonitorProjectServlet?cmd=start&proj_id="+selectedProjectId;
}

function stopProject(id){
	window.location="MonitorProjectServlet?cmd=stop&proj_id="+selectedProjectId;
}
</script>


<!--end of head -->
</head>

<!--Start of Body -->
<body>
<%@page session="false"%>
<%
	if (request.getSession(false) == null
			|| !request.getSession().getAttribute("priv").equals("A"))
		response.sendRedirect("Logout.jsp");
%>
<h2>PROJECT DETAILS</h2>
<hr>
<!--Projectview Form Declaration -->
<FORM NAME="Projectview" METHOD="post"><!--Creating table for displaying fields -->
<table border="0" align="center" CELLSPACING="2" CELLPADDING="1">
	<%
		Connection con = null;
		ConnectionPool connPool = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			//creating connection
			connPool = (ConnectionPool) application
					.getAttribute("connPool");
			con = connPool.getConnection();
			st = con.createStatement();
			//rs=st.executeQuery("select proj_id,proj_name,to_char(start_date,'DD-MM-YYYY:HH24:MI:SS'),to_char(end_date,'DD-MM-YYYY:HH24:MI:SS'),status,description from eurtf_monitoring_projects");
			rs = st
					.executeQuery("select proj_id,proj_name,DATE_FORMAT(start_date,'%d-%m-%y %H:%i:%S'),DATE_FORMAT(end_date,'%d-%m-%y %H:%i:%S'),status,description from eurtf_monitoring_projects");
			response.setContentType("text/html");
	%>

	<tr class="s3">
		<td class="s1">PROJECT ID</td>
		<td class="s1">PROJECT NAME</td>
		<td class="s1">START DATE</td>
		<td class="s1">END DATE</td>
		<td class="s1">STATUS</td>
		<td class="s1">DESCRIPTION</td>
		<td class="s1">&nbsp;</td>
		<td class="s1">&nbsp;</td>
		<td class="s1">&nbsp;</td>

	</tr>

	<%
		//for getting data from database
			int style = 1;
			while (rs.next()) {
	%>

	<tr
		class="s<%if (style == 1)
						out.print(style = 2);
					else
						out.print(style = 1);%>">

		<!--Dispalying fetched data-->
		<td class="s1"><%=rs.getString(1)%></td>
		<td class="s1"><%=rs.getString(2)%></td>
		<td class="s1"><%=rs.getString(3)%></td>
		<td class="s1"><%=rs.getString(4)%></td>
		<td class="s1"><%=rs.getString(5)%></td>
		<td class="s1"><%=rs.getString(6)%></td>

		<!--Link Forwarding to EditPage -->
		<td class="s1"><a
			href='MonitoringProjectEdit.jsp?ProjID=<%=rs.getString(1)%>'><img
			border="0" src="img/edit_button1.bmp" height="20" width="20"
			alt="click here to edit your record"><a> <!--Link Forwarding to DeletePage -->
		<td class="s1"><a
			href='/EURTF/MonitoringProjectDeleteServlet?ProjID=<%=rs.getString(1)%>'
			onClick="return confirm('Are you sure you want to delete this record?'); return false;"><img
			border="0" src="img/delete_button1.bmp" height="20" width="20"
			alt="click here to delete your record"></a>
		<td class="s1"><input type="radio" name="selected_project"
			onClick="getElementById('msg').innerHTML='Click on start to start the project \'<%=rs.getString(2)%> \'(project id <%=rs.getString(1)%>)';selectedProjectId=<%=rs.getString(1)%>;"></td>

	</tr>


	<%
		}//Closing while loop 

		}//Closing try block
		catch (Exception ex) {
		} finally {
			//releasing resources
			try {
				connPool.free(con);
				rs.close();
				st.close();
			} catch (Exception e) {
			}
		}
	%>

	<tr>
		<!--For displaying success/error message -->
		<%
			if (request.getAttribute("success") != null) {
				if (request.getAttribute("success") == "successdel") {
					out
							.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Project Deleted</font>");
				} else if (request.getAttribute("success") == "successup") {
					out
							.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Project Updated</font>");
				}
			}

			else if (request.getAttribute("error") != null) {
				if (request.getAttribute("error").equals("1")) {
					out
							.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Project ID already exists</font>");
				} else if (request.getAttribute("error").equals("17002")) {
					out
							.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Could not connect to the database, please try after sometime</font>");
				} else if (request.getAttribute("error") == "errordel") {
					out
							.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Cannot Delete the Project</font>");
				} else if (request.getAttribute("error") == "errorup") {
					out
							.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">cannot Update Project</font>");
				} else {
					out
							.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">cannot Update Project</font>");
				}
			}
		%>
	</tr>
	<tr>
		<td colspan="9" align="center">
		<fieldset style="align: center"><legend class="filter">TASK</legend>|--------------
		<input type="button" value="START" class="text"
			onClick="startProject()">--------------|--------------<input type="button"
			value="STOP" class="text" onClick="stopProject()">--------------|<br>
		<br>
		[<span id="msg" style="color: #000000">Select a project</span>]</fieldset>
		</td>
	</tr>

</table>

<!--closing the AgentView Form --></FORM>

<!--Closing Body -->
</body>

<!--Closing HTML Form-->
</html>

