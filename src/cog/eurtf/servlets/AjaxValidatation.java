package cog.eurtf.servlets;


import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cog.eurtf.jdbc.ConnectionPool;


public class AjaxValidatation extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	static final long serialVersionUID = 1L;
	public AjaxValidatation() {
		super();
	}   	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String projName=request.getParameter("projName");
		String transName=request.getParameter("transName");

		String agentName=request.getParameter("agentName");
		//System.out.println(transName);
		StringBuffer responseStr=new StringBuffer();

		responseStr.append("<valid>");
		if(transName != null){
			if (transName.equals("all"))
				transName="%";
			ConnectionPool pool=(ConnectionPool)getServletContext().getAttribute("connPool");
			Connection con=null;
			try {
				con=pool.getConnection();
				String query="SELECT DISTINCT a.agent_name FROM eurtf_agents a,eurtf_transactions t,eurtf_monitoring_projects p WHERE a.agent_id=t.agent_id AND t.proj_id=p.proj_id AND p.proj_name LIKE '"+projName+"' AND t.trans_name LIKE '"+transName+"'";
				//System.out.println(query);
				ResultSet rs=con.createStatement().executeQuery(query);
				int count=0;
				while(rs.next()){
					responseStr.append("<agent"+count+">"+rs.getString(1)+"</agent"+count+">");
					count++;
				}
				rs=null;
				responseStr.append("<count>"+(count)+"</count>");
				responseStr.append("</valid>");
				//System.out.println(responseStr);
			} catch (Exception e) {
				response.sendError(response.SC_BAD_REQUEST, "important_parameter needed");
			}
			finally{
				pool.free(con);

			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write(responseStr.toString());
		}


		else if(agentName != null){
			if (agentName.equals("all"))
				agentName="%";
			ConnectionPool pool=null;
			Connection con=null;
			try {
				pool=(ConnectionPool)getServletContext().getAttribute("connPool");
				con=pool.getConnection();
				String query="SELECT DISTINCT t.trans_name FROM eurtf_agents a,eurtf_transactions t,eurtf_monitoring_projects p WHERE a.agent_id=t.agent_id AND t.proj_id=p.proj_id AND p.proj_name LIKE '"+projName+"' AND a.agent_name LIKE '"+agentName+"'";
				ResultSet rs=con.createStatement().executeQuery(query);
				//System.out.println(query);
				int count=0;
				while(rs.next()){
					responseStr.append("<trans"+count+">"+rs.getString(1)+"</trans"+count+">");
					count++;
				}
				responseStr.append("<count>"+count+"</count>");
				responseStr.append("</valid>");
				//System.out.println(responseStr);
			} catch (Exception e) {
				response.sendError(response.SC_BAD_REQUEST, "important_parameter needed");
			}
			finally{
				pool.free(con);
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write(responseStr.toString());
		}
		else{
			response.sendError(response.SC_BAD_REQUEST, "important_parameter needed");
		}


	}  	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}   	  	    
}