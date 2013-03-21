package cog.eurtf.servlets;
/**
 * Author:Tamal Sen
 * Date:14/05/09
 * version:1.0
 *
 */

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;

import cog.eurtf.jdbc.ConnectionPool;


/**
 * Servlet implementation class for Servlet: DelSer
 *
 */

public class MonitoringProjectDeleteServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet 
{
	static final long serialVersionUID = 1L;
	Connection con=null;
	ConnectionPool connPool=null;
	Statement st=null;
	ResultSet rs=null;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
			try
			{
				//creating connection
				String projid=request.getParameter("ProjID");
		   		connPool=(ConnectionPool)getServletContext().getAttribute("connPool");
				con=connPool.getConnection();				st=con.createStatement();
				//rs=st.executeQuery("delete from eurtf_monitoring_projects where proj_id='"+projid+"'");
				st.executeUpdate("delete from eurtf_monitoring_projects where proj_id='"+projid+"'");
			
				//forwarding to MonitoringProjectView Page with success message
				RequestDispatcher rd=request.getRequestDispatcher("MonitoringProjectView.jsp");
				request.setAttribute("success","successdel");
				rd.forward(request,response);
			}			
			catch (Exception e) 
			{			
				//forwarding to MonitoringProjectView page with error message
				RequestDispatcher rd=request.getRequestDispatcher("MonitoringProjectView.jsp");
				request.setAttribute("error","errordel");
				rd.forward(request,response);
			}
			
			finally
			{
				//releasing resources
				
				try
				{
					connPool.free(con);
					rs.close();
					st.close();
				}
				catch(Exception e){}
			
			
			
			}  	
		
		 
		}	  	    
 	  	    
}