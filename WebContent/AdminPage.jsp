

<!--To prevent page caching -->
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@page session="false"%>

	<%
	if (request.getSession(false) == null || !request.getSession(false).getAttribute("priv").equals("A"))
				response.sendRedirect("Logout.jsp");
	%>
<html>
<head>
<title>ADMIN PAGE</title>
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
<script type="text/javascript" src="js/tab_control.js"></script>
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

<body onload="showDefaultTab('tab1');starttime()" class="dont">
<!-- For checking invalid users -->

<!-- TABS -->
<table border="0" align="center" height="800">
	<tr>

		<td class="tab" id="tab1" onclick="doFocus('tab1');"
			onmouseover="glow(this,'up')" onmouseout="glow(this,'down')"
			valign="top">PERFORMANCE DASHBOARD</td>

		<td class="tab" id="tab2" onclick="doFocus('tab2');"
			onmouseover="glow(this,'up')" onmouseout="glow(this,'down')">AGENTS</td>

		<td class="tab" id="tab3" onclick="doFocus('tab3');"
			onmouseover="glow(this,'up')" onmouseout="glow(this,'down')">PROJECTS</td>

		<td class="tab" id="tab4" onclick="doFocus('tab4');"
			onmouseover="glow(this,'up')" onmouseout="glow(this,'down')"
			valign="top">PAGETEST PARSER</td>


		<td width="500" align="right"
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
				<iframe id="perf_dashboard_frame" src=""
					width="100%" height="100%" target="#" style="border: none"></iframe>
				
				</td>
			</tr>
		</table>
</div>


				<div id="tab2_body">
				<table height="750" border="0">
					<tr>
						<td valign="middle">
						<table width="147" border="0" cellpadding="4" bgcolor="#8BB381">
							<thead style="font-size: 12;" align="center">
								<td>AGENT MANAGEMENT</td>
							</thead>
							<tr>
								<td align="center" class="tab" id="agnt_view_button"
									onmouseover="glow(this,'up')" onmouseout="glow(this,'down')"
									onclick="agnt_view_button.style.fontWeight='800';agnt_add_button.style.fontWeight='200';showBody('agnt','agnt_view_body')">VIEW
								AGENTS</td>
							</tr>
							<tr>
								<td align="center" class="tab" id="agnt_add_button"
									onmouseover="glow(this,'up')" onmouseout="glow(this,'down')"
									onclick="agnt_view_button.style.fontWeight='200';agnt_add_button.style.fontWeight='800';showBody('agnt','agnt_add_body')">ADD
								NEW AGENT</td>
							</tr>
						</table>

						</td>

						<td>
						<table border="0" cellpadding="4" bgcolor="#8BB381" width="902"
							height="750">
							<tr>
								<td class="tabBody" width="902">

								<div id="agnt_add_body"><iframe id="agnt_add_frame" src=""
									width="100%" height="100%" target="#"></iframe></div>

								<div id="agnt_view_body"><iframe id="agnt_view_frame"
									src="" width="100%" height="100%" target="#"></iframe></div>


								</td>
							</tr>
						</table>

						</td>

					</tr>
				</table>
				</div>



				<div id="tab3_body">

				<table height="750" border="0">
					<tr>
						<td valign="middle">
						<table width="147" border="0" cellpadding="4" bgcolor="#8BB381">
							<thead style="font-size: 12;" align="center">
								<td>PROJECT MANAGEMENT</td>
							</thead>
							<tr>
								<td align="center" class="tab" id="prjct_view_button"
									onmouseover="glow(this,'up')" onmouseout="glow(this,'down')"
									onclick="prjct_view_button.style.fontWeight='800';prjct_add_button.style.fontWeight='200';showBody('prjct','prjct_view_body')"
									title="view all projects">VIEW PROJECTS</td>
							</tr>
							<tr>
								<td align="center" class="tab" id="prjct_add_button"
									onmouseover="glow(this,'up')" onmouseout="glow(this,'down')"
									onclick="prjct_view_button.style.fontWeight='200';prjct_add_button.style.fontWeight='800';showBody('prjct','prjct_add_body')"
									title="add new projects">ADD NEW PROJECT</td>
							</tr>
						</table>

						</td>
						<td>

						<table border="0" cellpadding="4" bgcolor="#8BB381" width="902"
							height="750">
							<tr>
								<td class="tabBody" width="902">

								<div id="prjct_add_body"><iframe id="prjct_add_frame"
									src="" width="100%" height="100%" target="#"></iframe></div>

								<div id="prjct_view_body"><iframe id="prjct_view_frame"
									src="" width="100%" height="100%" target="#"></iframe></div>


								</td>
							</tr>
						</table>


						</td>
					</tr>
				</table>
				</div>



				<div id="tab4_body"><iframe id="page_test_frame" src=""
					width="100%" height="100%" target="#" style="border: none"></iframe></div>




				</td>
			</tr>
		</table>
</body>
</html>