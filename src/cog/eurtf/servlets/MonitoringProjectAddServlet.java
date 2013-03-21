package cog.eurtf.servlets;
/**
 * Author:Tamal Sen
 * Date:12/05/09
 * version:1.0
 *
 */

//importing classes
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cog.eurtf.jdbc.ConnectionPool;


/**
 * Servlet implementation class for Servlet: AddSer
 *
 */
public class MonitoringProjectAddServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet 
{
   static final long serialVersionUID = 1L;
   String projid;
   String projname;
   String sdate;
   String edate;
   String status;
   String desc;
   Connection con=null;
   ConnectionPool connPool=null;
   Statement stmt=null;
   
 

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
   {
	   //Getting parameter values
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
   			con=connPool.getConnection();
   			Statement stmt=con.createStatement();
		   
		   /********************************/
		   //FOR ORACLE
		   //sdate=sdate.replace(" ", ":");
		   //edate=edate.replace(" ", ":");
		   //stmt.executeQuery("insert into eurtf_monitoring_projects values('"+projid+"','"+projname+"',TO_DATE('"+sdate+"','DD-MM-YYYY:HH24:MI:SS'),TO_DATE('"+edate+"','DD-MM-YYYY:HH24:MI:SS'),'"+status+"','"+desc+"')");
		   /********************************/
   			
		   stmt.executeUpdate("insert into eurtf_monitoring_projects values('"+projid+"','"+projname+"',STR_TO_DATE('"+sdate+"','%d-%m-%Y %H:%i:%S'),STR_TO_DATE('"+edate+"','%d-%m-%Y %H:%i:%S'),'"+status+"','"+desc+"')");
		   
		   
		   //updating selected agents projectid foreign key with corresponding projectid
		   for(int i=0;sa!=null&&i<sa.length;i++)
		   {
			   //stmt.executeQuery("update eurtf_agents set proj_id='"+projid+"' where agent_name='"+sa[i]+"'");
			   stmt.executeUpdate("update eurtf_agents set proj_id='"+projid+"' where agent_name='"+sa[i]+"'");
		   }		
		
		   //forwarding to MonitoringProjectAdd page with success message
		   RequestDispatcher rd=request.getRequestDispatcher("MonitoringProjectAdd.jsp");
		   request.setAttribute("success","success");
		   rd.forward(request,response);
		} 
	   catch(SQLException e)
		{
		   	e.printStackTrace();
			//getting error message
			String str=""+e.getErrorCode();
			
			//forwarding to AgentAddPage with failure message
			RequestDispatcher rd=request.getRequestDispatcher("MonitoringProjectAdd.jsp");
			request.setAttribute("error",str);
			rd.forward(request,response);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			RequestDispatcher rd=request.getRequestDispatcher("MonitoringProjectAdd.jsp");
			request.setAttribute("error","error");
			rd.forward(request,response);
		}		
		finally
		{	
			//releasing resources
			try
			{
				projid=projname=sdate=edate=status=desc=null;
				connPool.free(con);
				stmt.close();
			}
			catch(Exception e){}
		} 
		
	}
}   	  	    
