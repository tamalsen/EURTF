
<%@page session="false"%>

	<%
		if (request.getSession(false) == null)
				response.sendRedirect("Logout.jsp");
	%>
<!--To prevent page caching -->
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<html>
<head>
<title>USER PAGE</title>
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
<script type="text/javascript" src="tab_control.js"></script>
<script>
function showDefaultTab(tabName){
	doFocus(tabName);
}


function glow(object, upDown){
	if(upDown=='up')
		object.style.color='#ffffff';

	if(upDown=='down')
		object.style.color='#6a3403';
} 


</script>
</head>

<body class="dont">
<!-- For checking invalid users -->

<!-- TABS -->
<table border="0" align="center" height="800" width="85%">
	<tr>

		<td class="tab" id="tab1">PERFORMANCE DASHBOARD</td>

		<td width="800px" align="right"
			style="font-size: 17px; letter-spacing: 3px; color: #6a3403; cursor: pointer;"><font size="2" color="#8BB381">Welcome <i><b><% if(request.getSession(false)!=null) out.print(request.getSession(false).getAttribute("user").toString().toUpperCase()); %></b></i></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><a
			href="Logout1.jsp">LOG OUT</a></b></td>
	</tr>

	




	<tr bgcolor="#f6c599" style="border-color: #0086FF;">
		<td colspan="5">

		<div id="tab1_body">
		<table width="100%" height="100%">
			<tr>
				<td id="real_time" height="40" width="200" align="center" bgcolor="#cfe0da"
					style="font-size: 19px; letter-spacing: 3px; color: #6a3403; cursor: pointer;"
					onmouseover="glow(this,'up')" onmouseout="glow(this,'down')" onclick="goRealTime()">REALTIME</td>
				<td id="historical" height="40"
					style="font-size: 19px; letter-spacing: 3px; color: #6a3403; cursor: pointer;"
					width="200" align="center" onmouseover="glow(this,'up')"
					onmouseout="glow(this,'down')" onclick="goHistorical()">HISTORICAL</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="3">
				<iframe id="perf_dashboard_frame" src="Dashboard.jsp?chartType=realtime"
					width="100%" height="100%" target="#" style="border: none"></iframe>
				
				</td>
			</tr>
		</table>
</div>




				</td>
			</tr>
		</table>
</body>
</html>