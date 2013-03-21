


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
    
<!--importing classes -->
<%@ page import="java.sql.*,cog.eurtf.jdbc.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--start of HTML form -->
<html>

<!--start of head -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!--title to be displayed in title bar -->
<title>Agent Edit Page</title>

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
           Agentedit.submit();
        }  
       
}
</script>

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
<h2>AGENT ADMINISTRATION</h2>
<hr>
	<fieldset style="width:500px;" align="center"><legend>EDIT AGENT</legend>
	<!--Agentedit Form Declaration -->
	<form name="Agentedit" method="POST" action="AgentEditServlet">
	<!--To get values for that record -->
	<%
		//reading parameter
		String yourid=request.getParameter("yourid");
		Connection con=null;
		ConnectionPool connPool=null;
		Statement st=null;
		ResultSet rs=null;
  		try
  		{
	    	//creating connection
			connPool=(ConnectionPool)application.getAttribute("connPool");
			con=connPool.getConnection();
			st=con.createStatement();
			rs=st.executeQuery("select * from eurtf_agents where agent_id='"+yourid+"'");
			response.setContentType("text/html");
			rs.next();
					
	  %>
	  
	<!--Creating table for displaying fields -->
	<table align="center" cellspacing="5" cellpadding=5>
		
		<!--TextBox for getting Agent ID in hidden field -->	
		<tr>
			<td>
			<input type="text" class="text" name="up_id"  readonly="true" size="40" value="<%=rs.getString(1)%>"  style="display:none";>
			</td>
		</tr>

		<!--TextBox for getting Agent ID to be updated -->
		<tr>
      		<td>Agent ID </td>      
    		<td><input type="text" class="text" name="yourid" id="AID1" size=20 value="<%=rs.getString(1)%>" maxlength="10"><font color="#FF0000">*</font></td>
       	</tr>
    	
    	<!--TextBox for getting Agent Name -->
    	<tr>
    		<td>Agent Name </td>    
    		<td><input type="text" class="text"name="yourname" id="AID2" size=20 value="<%=rs.getString(2)%>" maxlength="30"><font color="#FF0000">*</font></td>
       	</tr>
    	
    	<!--TextBox for getting Agent Location --> 
    	<tr>
    		<td>Agent Location</td>
    		<td> <input type="text" class="text" name="yourloc" id="AID3" size=20 value="<%=rs.getString(3)%>" maxlength="20"><font color="#FF0000">*</font></td>
    	</tr>
    	
    	<!--TextBox for getting Agent IP address -->
    	<tr>
    		<td>Agent IP Address</td>
    		<td><input type="text" class="text" name="yourip" id="AID4" size=20 value="<%=rs.getString(4)%>" maxlength="15"><font color="#FF0000">*</font></td>
    	</tr>
    	
    	<!--MultiLine TextBox for getting user Comments -->
    	<tr>
    		<td>Comments</td>
    		<td><textarea  class="text" name="yourcomments" rows="10" cols="24" maxlength="50"><%=rs.getString(5)%></textarea>
    	</td>
    	
		</tr>
	</table>
	
	<table align="center">
		<tr>
		
		<!--For displaying Update button -->
		<td><input type="submit" class="btn1" name="myButton6" value="Update">&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="button"  class="btn1" VALUE="CANCEL" OnClick="window.location='AgentViewPage.jsp'"></td>
 		<%
		}
  		finally
  		{
  			//releasing resources
  			connPool.free(con);
  			st.close();
  			rs.close();
	  
	  	}
	
		%>
 		</tr>
	</table>

	<!--closing the Agentedit Form -->
	</form>
</fieldset>
<!--Closing Body -->	
</body>

<!--Closing HTML Form-->
</html>
