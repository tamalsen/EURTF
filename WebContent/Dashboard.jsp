<%@page session="false"%>
<!--To prevent page caching -->
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%><html>

<head>
<title>PERFORMANCE DASHBOARD</title>

<link rel="stylesheet" type="text/css" href="calender/rfnet.css" />
<script type="text/javascript" src="calender/datetimepicker_css.js"></script>

<link rel="stylesheet" type="text/css" href="css/mystyle.css" />




<!-- ************************Fetch all project names which has transactions**********************************************************-->
<%@  page import="le.*,java.util.*"%>
<%
	ArrayList<String> list = new ArrayList<String>();
	LoadElement loadElement = new LoadElement();
%>
<%
	list = loadElement.fetchTransactionData("project", "");
	String initProjName = "";

	if (list != null) {
		initProjName = list.get(0);

		String projectStr = request.getParameter("projectName");
		if (projectStr == null) {
			projectStr = initProjName;
		}
%>
<!-- ********************************************************************************************************-->



<!-- *********************************************Script for AJAX***********************************************************-->
<script>
	var req;
	var target;
	var isIE;

	function initRequest(url) {
		if (window.XMLHttpRequest) {
			req = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			isIE = true;
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}

	var str = "";
	function getValues(which) {
		str = "";
		for (i = 0; i < document.getElementById(which).options.length; i++) {
			if (document.getElementById(which).options[i].selected) {
				var dd = document.getElementById(which).options[i].value;
				str = dd;
			}
		}
	}

	function selectAgent() {
		getValues("transaction");
		if (!target)
			target = document.getElementById("transaction");
		var url = "AjaxValidatation?projName=<%=projectStr%>&transName=" + str; //project name should be dynamic 
		initRequest(url);
		req.onreadystatechange = processRequest_1;
		req.open("GET", url, true);
		req.send(null);
	}

	function selectTrans() {
		getValues("AgentName");
		if (!target)
			target = document.getElementById("agentName");
		var url = "AjaxValidatation?projName=<%=projectStr%>&agentName=" + str; //project name should be dynamic 
		initRequest(url);
		req.onreadystatechange = processRequest_2;
		req.open("GET", url, true);
		req.send(null);
	}

	function processRequest_1() {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var count = req.responseXML.getElementsByTagName("count")[0].childNodes[0].nodeValue;
				for (j = 0; j < document.getElementById("agentName").length; j++) 
						document.getElementById("agentName").options[j].selected = false;
					
				for (i = 0; i < count; i++) {
					var trans = req.responseXML.getElementsByTagName("agent"
							+ i)[0].childNodes[0].nodeValue;
					for (j = 0; j < document.getElementById("agentName").length; j++) {
						if (document.getElementById("agentName").options[j].value == trans)
							document.getElementById("agentName").options[j].selected = true;
						else{}

					}
				}
			}
		}
	}

	function processRequest_2() {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var count = req.responseXML.getElementsByTagName("count")[0].childNodes[0].nodeValue;
				for (j = 0; j < document.getElementById("transaction").length; j++) 
						document.getElementById("transaction").options[j].selected = false;
					
				for (i = 0; i < count; i++) {
					var trans = req.responseXML.getElementsByTagName("trans"+ i)[0].childNodes[0].nodeValue;
					for (j = 0; j < document.getElementById("transaction").length; j++) {
						if (document.getElementById("transaction").options[j].value == trans)
							document.getElementById("transaction").options[j].selected = true;
						else{}

					}
				}
			}
		}
	}

	</script>
<!-- ******************************************************************************************************************-->


<!-- ***************************************Code for opaning a popup***************************************************-->
<script>
	function popup(mylink)
	{
		if (! window.focus)return true;
		var href;
		if (typeof(mylink) == 'string')
	   		href=mylink;
		else
	   		href=mylink.href;
			window.open(href, "waterfall", 'width=800,height=600,scrollbars=yes');
	}
		
</script>
<!-- ********************************************************************************************************-->


<!-- **************************************If chart type is realtime then auto refresh the page********************************************-->
<script>
<%if (request.getParameter("chartType").equals("realtime")) {%>

var limit="0:60"

	if (document.images){
	var parselimit=limit.split(":")
	parselimit=parselimit[0]*60+parselimit[1]*1
	}
	function beginrefresh(){
	if (!document.images)
	return
	if (parselimit==1)
	window.location.reload()
	else{ 
	parselimit-=1
	curmin=Math.floor(parselimit/60)
	cursec=parselimit%60
	if (curmin!=0)
	curtime=curmin+" MINUTES and "+cursec+" SECONDS LEFT until PAGE REFRESH!"
	else
	curtime=cursec+" SECONDS LEFT until PAGE REFRESH!"
	document.getElementById("countDown").innerHTML=curtime;
	setTimeout("beginrefresh()",1000)
	}
	}

	window.onload=beginrefresh
	//-->

<%} else {%>
window.status="done";
<%}%>

</script>
<!-- ********************************************************************************************************-->


</head>
<body bgcolor="#f6c599">


<%
	if (request.getSession(false) == null)
			response.sendRedirect("Logout.jsp");
%>
<h2><%=request.getParameter("chartType").toUpperCase()%>
PERFORMANCE DASHBOARD</h2>
<hr>



<form name="dashboard" action="Dashboard.jsp" method="post">
<table width="100%" border=0>
	<tr align="right">


		<td style="width: 300px" colspan="" class="filter">
		<fieldset><legend style="font-size: 15px">Select a
		Project Name</legend> <b>FILTER BY:&nbsp;&nbsp;</b><select name="projectName"
			onchange="dashboard.submit()">
			<%
				for (int i = 0; i < list.size(); i++) {
						String def = "";
						if (list.get(i).equals(projectStr))
							def = "selected=\"selected\"";
						out.println("<OPTION VALUE=" + list.get(i) + " " + def
								+ ">" + list.get(i) + "</OPTION>");
					}
			%>
		</select></fieldset>
		</td>
	</tr>


	<%
		ArrayList<String[]> projectDateList = new ArrayList<String[]>();
			projectDateList = loadElement.fetchProjectDate(projectStr);
	%>

	<jsp:include page="/MakeChart">
		<jsp:param name="project" value="<%=projectStr%>" />
	</jsp:include>



	<tr>
		<td width="" bgcolor="#C6DEFF" align="center">
	<script type="text/javascript" src="amxy/swfobject.js"></script>
	<script type="text/javascript" src="amxy/chart_settings.js"></script>
		<div id="flashcontent"><strong>You need to upgrade your
		Flash Player</strong></div>
		<table align="right">
			<tr>
				<td>
				<div style="z-index: -1"><script type="text/javascript">
	// <![CDATA[		
	var so = new SWFObject("amxy/amxy.swf", "amxy", "800", "400", "8", "#FFFFFF");
	so.addVariable("settings_file", "amxy/amxy_settings.xml");
	so.addVariable("data_file","amxy/chart_data.xml");
	so.addVariable("path", "");
	so.addVariable("chart_id", "amxy");
	so.addParam("wmode", "transparent");
	so.write("flashcontent");

	// ]]>
	</script> <script type="text/javascript">
	var flashMovie;
	function amChartInited(chart_id) {
		// get the flash object into "flashMovie" variable   
		flashMovie = document.getElementById(chart_id);
		ss();
		// tell the field with id "chartfinished" that this chart was initialized
	}

</script></div>

				</td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td>

		<table align="center" border="0" cellpadding="2" width="100%">
			<tr>

				<%
					if (request.getParameter("chartType").equals("historical")) {
				%>
				<td style="width: 300px" align="left" class="filter">
				<fieldset><legend style="font-size: 15px">Filter
				using date</legend> <b>START DATE: </b><a
					href="javascript: NewCssCal('start_date','ddmmyyyy','dropdown',true,15,false)"><img
					src="calender/cal.gif"></a><input type="text" name="start_date"
					onFocus="blur();" value="<%=projectDateList.get(0)[0]%>"><br>
				<br>
				<br>
				<b> END DATE: &nbsp; &nbsp;</b><a
					href="javascript: NewCssCal('end_date','ddmmyyyy','dropdown',true,24,false)"><img
					src="calender/cal.gif"></a><input type="text" name="end_date"
					onFocus="blur();" value="<%=projectDateList.get(0)[1]%>"><br>
				<br>
				<br>
				<br>
				</fieldset>
				</td>
				<%
					}
				%>
				<td style="width: 300px" class="filter" align="center">
				<fieldset><legend style="font-size: 15px">Filter
				using Transaction Name</legend> <select name="transaction"
					multiple="multiple" size=5 style="z-index: 0"
					onchange="selectAgent()" style="width:100px">
					<option value="all">ALL</option>
					<%
						list = loadElement.fetchTransactionData("transaction",
									projectStr);
							for (int i = 0; i < list.size(); i++)
								out.println("<OPTION VALUE=" + list.get(i) + ">"
										+ list.get(i) + "</OPTION>");
					%>
				</select></fieldset>
				</td>
				<td></td>
				<td class="filter" style="width: 300px" align="center">
				<fieldset><legend style="font-size: 15px">Filter
				using Agent Name</legend> <select name="agentName" multiple="multiple" size=5
					onchange="selectTrans()" style="width: 100px">
					<option value="all">ALL</option>
					<%
						list = loadElement.fetchTransactionData("agent", projectStr);
							for (int i = 0; i < list.size(); i++)
								out.println("<OPTION VALUE=" + list.get(i) + ">"
										+ list.get(i) + "</OPTION>");
					%>
				</select></fieldset>
				</td>
				<td align="center" class="filter">
				<fieldset><!-- <legend style="font-size: 15px"></legend> -->
				<input type="reset" class="btn1" value="RESET" onclick=""><br>

				<br>
				<input type="button" class="btn1" value="UPDATE"
					onclick="<%if (request.getParameter("chartType").equals("realtime")) {%>document.getElementById('typeChart').value='realtime';<%}%>dashboard.submit();"><br>
				<br>

				</fieldset>
				</td>

			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3">
		<%
			if (!request.getParameter("chartType").equals("historical")) {
		%> <span align="center" id="countDown" class="filter"></span> <%
 	}
 %>
		</td>
	</tr>
</table>
<input type="hidden" value="historical" name="chartType" id="typeChart">
</form>


<%
	} else {
		out.print("DATABASE NOT POPULATED....!!");

	}
%>





<!-- <table style="position:absolute;left:80px;top:100px;background-color:#C6DEFF;" width="150" height="30">
<tr>
<td></td>
</tr>
</table> -->

</body>
</html>