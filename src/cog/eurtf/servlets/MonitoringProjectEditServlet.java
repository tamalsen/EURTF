package cog.eurtf.servlets;
/**
 * Author:Tamal Sen
 * Date:15/05/09
 * version:1.0
 *
 */



import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;

import cog.eurtf.jdbc.ConnectionPool;


/**
 * Servlet implementation class for Servlet: EditSer
 *
 */
public class MonitoringProjectEditServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet 
{
	static final long serialVersionUID = 1L;
	String projid;
	String projname;
	String sdate;
	String edate;
	String status;
	String desc;
	String prid;
	Connection con=null;
	ConnectionPool connPool=null;
	Statement stmt=null;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//Getting parameter values
		prid=request.getParameter("Prid");
		projid=request.getParameter("ProjID");
		projname=request.getParameter("ProjName");
		sdate=request.getParameter("Sdt");
		edate=request.getParameter("Edt");
		status=request.getParameter("Status");
		desc=request.getParameter("desc");
		String sa[]=request.getParameterValues("SelAgents");
		
		try
		{
			//creating connection
	   		connPool=(ConnectionPool)getServletContext().getAttribute("connPool");
			con=connPool.getConnection();			stmt=con.createStatement();
	        //sdate=sdate.replace(" ", ":");
	        //edate=edate.replace(" ", ":");
	        //System.out.println("update eurtf_monitoring_projects set proj_id='"+projid+"',proj_name='"+projname+"',start_date=STR_TO_DATE('"+sdate+"','%d-%m-%Y %H:%i:%S'),end_date=STR_TO_DATE('"+edate+"','%d-%m-%Y %H:%i:%S'),status='"+status+"',description='"+desc+"' where proj_id='"+prid+"'");
	        stmt.executeUpdate("update eurtf_monitoring_projects set proj_id='"+projid+"',proj_name='"+projname+"',start_date=STR_TO_DATE('"+sdate+"','%d-%m-%Y %H:%i:%S'),end_date=STR_TO_DATE('"+edate+"','%d-%m-%Y %H:%i:%S'),status='"+status+"',description='"+desc+"' where proj_id='"+prid+"'");

		    if(status.equals("Stopped"))
		    {
		    	stmt.executeUpdate("update eurtf_agents set proj_id = null where proj_id='"+projid+"'");
		    }
		    else
		    {
		    	stmt.executeUpdate("update eurtf_agents set proj_id= null where proj_id='"+projid+"'");
		    	for(int i=0;sa!=null&&i<sa.length;i++)
		    	{
		    		stmt.executeUpdate("update eurtf_agents set proj_id='"+projid+"' where agent_name='"+sa[i]+"'");
		    	}
		    }		
	    
		    //forwarding to MonitoringProjectView page with success message
		    RequestDispatcher rd=request.getRequestDispatcher("MonitoringProjectView.jsp");
		    request.setAttribute("success","successup");
		    rd.forward(request,response);
		}
		catch(SQLException e)
		{	
			//getting error message
			String str=""+e.getErrorCode();
			
			//forwarding to AgentAddPage with failure message
			RequestDispatcher rd=request.getRequestDispatcher("MonitoringProjectView.jsp");
			request.setAttribute("error",str);
			rd.forward(request,response);
		}
		catch(Exception e)
		{
			RequestDispatcher rd=request.getRequestDispatcher("MonitoringProjectView.jsp");
			request.setAttribute("error","errorup");
			rd.forward(request,response);
		}		

		finally
		{
			//releasing resources
			try
			{
				projid=projname=sdate=edate=status=desc=null;
				con.close();
				stmt.close();
			}
			catch(Exception e){}
			
		}  	
	
	}   	  	    
}