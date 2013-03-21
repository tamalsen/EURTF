package cog.eurtf.servlets;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cog.eurtf.chart.GenerateXML;
import cog.eurtf.jdbc.ConnectionPool;



public class MakeChart extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	static final long serialVersionUID = 1L;

	//Realtime chart will show data of this timespan..(in minutes)
	private final byte REALTIME_TIME_SPAN=20; 
	public MakeChart() {
		super();
	}   	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ConnectionPool connPool=null;
		Connection con=null;
		//response.getWriter().print("THIS:"+request.getParameter("project"));

		//System.out.println("transactionName:"+request.getParameter("transaction"));

		String transactions[]={"%"};
		transactions=request.getParameterValues("transaction");
		if(transactions==null||transactions[0].equals("all"))
			transactions=new String[]{"%"};
		
		String agents[]={"%"};
		agents=request.getParameterValues("agentName");
		if(agents==null||agents[0].equals("all"))
			agents=new String[]{"%"};

		String project=request.getParameter("project");



		Date curDate=new Date();
		String endDate=" p.start_date ";
		String startDate=" p.end_date ";

		String chartType=request.getParameter("chartType");
		if(chartType==null)
			chartType="realtime";

		if(chartType.equals("realtime")){
			endDate="'"+curDate.toString().toUpperCase().replace("GMT+05:30", "")+"'";
			startDate="'"+(new Date(curDate.getTime()-(1000*60*REALTIME_TIME_SPAN)).toString().toUpperCase().replace("GMT+05:30", ""))+"'";
		}

		if(chartType.equals("historical")){
			DateFormat formatter=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			Date start=null;
			Date end=null;
			try {
				if(request.getParameter("start_date") != null && request.getParameter("end_date") !=null){
					start = (Date)formatter.parse(request.getParameter("start_date"));
					end = (Date)formatter.parse(request.getParameter("end_date"));
					startDate="'"+start.toString().toUpperCase().replace("GMT+05:30", "")+"'";
					endDate="'"+end.toString().toUpperCase().replace("GMT+05:30", "")+"'";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		StringBuffer query=new StringBuffer("");
		query.append("SELECT a.agent_name AGENT_NAME,t.trans_name TRANS_NAME, DATE_FORMAT(t.trans_date,'%Y-%m-%d %H:%i:%S') TRANS_DATE,t.time_to_fully_loaded TIME_TO_FULLY_LOADED,t.ifile_url IFILE_URL,p.proj_name PROJ_NAME from eurtf_agents a,eurtf_transactions t,eurtf_monitoring_projects p where a.agent_id=t.agent_id AND p.proj_id=t.proj_id AND p.proj_name LIKE '"+project+"' AND");
		
		query.append("(");
		boolean flag=true;
		for(int i=0;i<transactions.length;i++){
			if(!flag)
				query.append(" OR ");
			flag=false;
			query.append(" t.trans_name LIKE '"+transactions[i]+"' ");
		}
		query.append(")");

		query.append(" AND ");
		
		query.append("(");
		flag=true;
		for(int i=0;i<agents.length;i++){
			if(!flag)
				query.append(" OR ");
			flag=false;
			query.append(" a.agent_name LIKE '"+agents[i]+"' ");
		}
		query.append(")");

		
		query.append(" AND (trans_date BETWEEN STR_TO_DATE("+startDate+",'%a %b %d %H:%i:%S %Y') AND str_to_date("+endDate+",'%a %b %d %H:%i:%S %Y')) order by trans_name,trans_date");

		//response.getWriter().print(query);
		//System.out.println(query);
		try {
			String path = getServletContext().getRealPath("/");
			
			//path="./";
			//path=".\\webapps\\EURTF\\";
			//response.getWriter().print(path);
			connPool=(ConnectionPool)getServletContext().getAttribute("connPool");
			con=connPool.getConnection();
			GenerateXML gx=new GenerateXML(con,path+"amxy\\chart_data.xml",path+"amxy\\chart_settings.js");
			//response.getWriter().print(
			gx.generate(query.toString());
			//+" data found");
		} catch (Exception e) {
		}
		finally{
			try{
				connPool.free(con);
			}catch(Exception e){}
		}

	}   	  	    
}