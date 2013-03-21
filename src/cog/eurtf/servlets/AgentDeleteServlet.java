package cog.eurtf.servlets;


/**
 * Author:Tamal Sen
 * Date:14/05/09
 * version:1.0
 *
 */


//importing classes
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cog.eurtf.jdbc.ConnectionPool;


public class AgentDeleteServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet 
{
	static final long serialVersionUID = 1L;
	ConnectionPool connPool=null;
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			//reading parameters
			String yourid=request.getParameter("yourid");

			//creating connection
			connPool=(ConnectionPool)getServletContext().getAttribute("connPool");
			con=connPool.getConnection();
			st=con.createStatement();
			//rs=st.executeQuery("delete from eurtf_agents where agent_id='"+yourid+"'");
			st.executeUpdate("delete from eurtf_agents where agent_id='"+yourid+"'");

			//forwarding to AgentView Page with success message
			RequestDispatcher rd=request.getRequestDispatcher("AgentViewPage.jsp");
			request.setAttribute("success","successdel");
			rd.forward(request,response);
		}
		catch (Exception e)
		{
			//forwarding to AgentView page with error message
			RequestDispatcher rd=request.getRequestDispatcher("AgentViewPage.jsp");
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