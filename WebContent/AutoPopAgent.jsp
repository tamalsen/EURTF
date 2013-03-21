<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page
	import="java.util.*,java.sql.*"
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Select Agents</title>
<script>
function validate(){
window.opener.UploadForm[3].value=popup_select[0].value;
window.close();
}
</script>
</head>
<body onblur="self.focus()">
<form name="popup_select">
<SELECT NAME="agent" id="Agent" size=10 ondblclick="validate()">
<% 
	ArrayList S=(ArrayList)request.getAttribute("retname");
	if(S!=null)
	{
	for(int i=0;i<S.size();i++)
	{
	//inserting agents names into list
	out.println("<OPTION VALUE="+S.get(i)+">"+S.get(i));
	}
	}
	else
	{
	out.println("No Agents for this project");
	}
	S=null;
%>
<input type="button" value="Close" onclick="window.close()">

</SELECT>

</form>
</body>
</html>