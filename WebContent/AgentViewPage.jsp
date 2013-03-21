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
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 
<%@ page import="cog.eurtf.jdbc.*" %> 
<!--start of HTML form -->
<html>

<!--start of head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!--title to be displayed in title bar -->
<title>Agent View Page</title>
<!--Including Stylesheet -->
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
<!--end of head -->
</head>

<!--Start of Body -->
<body >
<!--To prevent page caching -->
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@page session="false"%>
	<%
	
	if (request.getSession(false) == null|| !request.getSession().getAttribute("priv").equals("A"))
			response.sendRedirect("Logout.jsp");
	%>
<h2>AGENT DETAILS</h2>
<hr>
	<!--Agentview Form Declaration -->
	<FORM NAME="agentview" METHOD="POST">
	<table border="0" CELLSPACING="2" CELLPADDING="1" align="center">
		
		<!--Displaying labels -->
		<tr class="s3">
		<td class="s1">AGENT ID</td>
		<td class="s1">AGENT NAME</td>
		<td class="s1">AGENT LOCATION</td>
		<td class="s1">AGENT IP</td>
		<td class="s1">COMMENTS</td>
		<td class="s1">PROJ_ID</td>
<td class="s1">&nbsp;	
</td >
<td class="s1">&nbsp;
</td>

</tr>

		<%
			Connection con = null;
			ConnectionPool connPool = null;
			Statement st=null;
			ResultSet rs=null;
	  		try
	  		{
		    	//creating connection
				connPool=(ConnectionPool)application.getAttribute("connPool");
				con=connPool.getConnection();
				if(con==null)
					out.print("could not connect");

				 
				st = con.createStatement();
				rs = st.executeQuery("select * from eurtf_agents");
				response.setContentType("text/html");
				int style=1;
				
				//for getting data from database
				while (rs.next()) {
		%>
    	
    	<!--Table for dispalying fetched data-->
    	<tr class="s<%if(style==1)out.print(style=2);else out.print(style=1); %>">
        	<td class="s1"><%=rs.getString(1)%></td>
        	<td class="s1"><%=rs.getString(2)%></td>
        	<td class="s1"><%=rs.getString(3)%></td>
        	<td class="s1"><%=rs.getString(4)%></td>
        	<td class="s1"><%=rs.getString(5)%></td>
        	<td class="s1"><%=rs.getString(6)%></td>
        	
        	<!--Link Forwarding to EditPage -->
        	<td class="s1"> <a href='AgentEditPage.jsp?yourid=<%=rs.getString(1)%>'><img border="0" src="img/edit_button1.bmp" height="20" width="20" alt="click here to edit your record"></a></td>
        	
        	<!--Link Forwarding to DeletePage -->
     		<td class="s1"> <a href="AgentDeleteServlet?yourid=<%=rs.getString(1)%>" onClick="return confirm('Are you sure you want to delete this record?'); return false;"><img border="0" src="img/delete_button1.bmp" height="20" width="20" alt="click here to delete your record"></a>
    		</tr>
  
  
    	<%
        		}

        		} catch (Exception ex) {
        		} finally {
        			try {
        				//releasing resources
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
    					.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Agent Deleted</font>");
    				} else if (request.getAttribute("success") == "successup") {
    					out
    					.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Agent Updated</font>");
    				}
    			}

    			else if (request.getAttribute("error") != null) {
    				if (request.getAttribute("error").equals("1")) {
    					out
    					.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Agent ID already exists</font>");
    				} else if (request.getAttribute("error").equals("17002")) {
    					out
    					.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Could not connect to the database, please try after sometime</font>");
    				} else if (request.getAttribute("error") == "errordel") {
    					out
    					.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">Cannot Delete the Agent</font>");
    				} else if (request.getAttribute("error") == "errorup") {
    					out
    					.println("<font size=4 face=\"Verdana\" color=\"#C11B17\">cannot Update Agent</font>");
    				}
    			}
    		%>
		</tr>
	</table>
	
	<!--closing the AgentView Form -->
	</form>
	
<!--Closing Body -->
</body>

<!--Closing HTML Form-->
</html>
				
