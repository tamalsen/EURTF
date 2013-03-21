<%@page session="false"%>
<%

if (request.getSession(false) == null)
			response.sendRedirect("Logout.jsp");
%>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<html>
<head>
<title>WATERFALL DETAILS</title>
</head>
<body bgcolor="#909090">
<center style="font-size:20px"><b>AGENT NAME: </b><i><%=request.getParameter("agent_name") %></i></center>
<center style="font-size:20px"><b>TRANSACTION NAME: </b><i><%=request.getParameter("trans_name") %></i></center>

<center><img src="<%=request.getParameter("ifile") %>"></center>
</body>
</html>