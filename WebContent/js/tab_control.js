function clearTabs(){
	document.getElementById('tab1').background='img/tab_unpressed.gif';
	document.getElementById('tab2').background='img/tab_unpressed.gif';
	document.getElementById('tab3').background='img/tab_unpressed.gif';
	document.getElementById('tab4').background='img/tab_unpressed.gif';

	document.getElementById('tab1').style.border='none';
	document.getElementById('tab2').style.border='none';
	document.getElementById('tab3').style.border='none';
	document.getElementById('tab4').style.border='none';

	document.getElementById('tab1_body').style.display='none';
	document.getElementById('tab2_body').style.display='none';
	document.getElementById('tab3_body').style.display='none';
	document.getElementById('tab4_body').style.display='none';

}

function doFocus(tabName){

	clearTabs();
	document.getElementById(tabName).background='';
	document.getElementById(tabName).style.border='thin';
	document.getElementById(tabName).style.borderStyle='inset';
	document.getElementById(tabName).style.borderBottomColor='#f6c599';
	document.getElementById(tabName+'_body').style.display='block';
	initTabBody(tabName+'_body');
	

}


var agntAddUrl="AgentAddPage.jsp";
var agntViewUrl="AgentViewPage.jsp";

var prjctAddUrl="MonitoringProjectAdd.jsp";
var prjctViewUrl="MonitoringProjectView.jsp";

var pageTestUrl="PageTestParser.jsp"

var RT_perfDashUrl="Dashboard.jsp?chartType=realtime";
var H_perfDashUrl="Dashboard.jsp?chartType=historical";

var agntAddLoad=true;
var agntViewLoad=true;

var prjctAddLoad=true;
var prjctViewLoad=true;

var pageTestLoad=true;

var perfDashLoad=true;

function initTabBody(tabBody){

	if(tabBody=="tab2_body"){  //for add agent
		document.getElementById('agnt_view_button').style.fontWeight='800';
		document.getElementById('agnt_add_button').style.fontWeight='normal';
		showBody('agnt','agnt_view_body');
	}

	else if(tabBody=="tab3_body"){  //for project
		
		document.getElementById('prjct_view_button').style.fontWeight='800';
		document.getElementById('prjct_add_button').style.fontWeight='normal';
		showBody('prjct','prjct_view_body');
	}
	
	else if(tabBody=="tab4_body" && pageTestLoad){
		document.getElementById('page_test_frame').src=pageTestUrl;
	}
	else if(tabBody=="tab1_body" && perfDashLoad){
		goRealTime();
		//pageTestLoad=false;
	}

}





function showBody(agnt_prjct,bodyName){
	if(agnt_prjct=="agnt"){
		document.getElementById('agnt_add_body').style.display='none';
		document.getElementById('agnt_view_body').style.display='none';
		document.getElementById(bodyName).style.display='block';
		
		if(bodyName=="agnt_add_body" && agntAddLoad){
			document.getElementById('agnt_add_frame').src=agntAddUrl;
		}
		
		if(bodyName=="agnt_view_body" && agntViewLoad){
			document.getElementById('agnt_view_frame').src=agntViewUrl;
		}
			
	}
	
	if(agnt_prjct=="prjct"){
		document.getElementById('prjct_add_body').style.display='none';
		document.getElementById('prjct_view_body').style.display='none';
		document.getElementById(bodyName).style.display='block';
		
		if(bodyName=="prjct_add_body" && prjctAddLoad){
			document.getElementById('prjct_add_frame').src=prjctAddUrl;
		}
		
		if(bodyName=="prjct_view_body" && prjctViewLoad){
			document.getElementById('prjct_view_frame').src=prjctViewUrl;
		}
			
	}
	
	
}


function goRealTime(){
	document.getElementById('real_time').style.fontWeight='800';
	document.getElementById('historical').style.fontWeight='normal';
	document.getElementById('historical').style.backgroundColor='#f6c599';
	document.getElementById('real_time').style.backgroundColor='#cfe0da';
	document.getElementById('perf_dashboard_frame').src=RT_perfDashUrl;
	
}


function goHistorical(){
	document.getElementById('historical').style.fontWeight='800';
	document.getElementById('real_time').style.fontWeight='normal';
	document.getElementById('real_time').style.backgroundColor='#f6c599';
	document.getElementById('historical').style.backgroundColor='#cfe0da';
	document.getElementById('perf_dashboard_frame').src=H_perfDashUrl;
}

