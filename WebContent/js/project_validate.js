function forward()
	{
		index=document.getElementById('ReqAgents').selectedIndex;
		value=document.getElementById('ReqAgents').options[index].value;
		text=document.getElementById('ReqAgents').options[index].text;
	
		var optn = document.createElement('OPTION');
		optn.text=text;
		document.getElementById("SelAgents").options.add(optn);
		document.getElementById('ReqAgents').options[index]=null;
	
	}

	function reverse()
	{
		index=document.getElementById('SelAgents').selectedIndex;
		value=document.getElementById('SelAgents').options[index].value;
		text=document.getElementById('SelAgents').options[index].text;
	
		var optn = document.createElement('OPTION');
		optn.text=text;
		document.getElementById("ReqAgents").options.add(optn);
		document.getElementById('SelAgents').options[index]=null;
	}

	function selectAllOptions(selStr)
	{
  		var selObj = document.getElementById(selStr);
  		for (var i=0; i<selObj.options.length; i++) 
  		{
    		selObj.options[i].selected = true;
  		}
	}

	function validate()
 	{
 		var SDate = Project.Sdt.value;
		var EDate = Project.Edt.value;
		var endDate = Date.parse(EDate);
		var startDate = Date.parse(SDate);
	
 		if(document.getElementById("ProjID").value=="")
		{
			alert("Enter the Project ID")
		}
		else if(document.getElementById("ProjName").value=="")
		{
			alert("Enter the Project Name")
		}
		
		else if(document.getElementById("Sdt").value=="")
		{
			alert("Select the Start Date and Time")
		}
	
		else if(document.getElementById("Edt").value=="")
		{
			alert("Select the End date and Time")
		}
		else if(startDate > endDate)  
		{      
	    	 alert("Please ensure that the End Date is greater than or equal to the Start Date.");  
		} 
	
    	else
        {
           selectAllOptions('SelAgents');
           Project.submit();
       	}
}