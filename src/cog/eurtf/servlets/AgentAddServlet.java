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
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cog.eurtf.jdbc.ConnectionPool;


public class AgentAddServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet  {
   static final long serialVersionUID = 1L;
   String yourid;
   String yourname;
   String yourip;
   String yourloc;
   String yourcomments;
   ConnectionPool connPool=null;
   Connection con=null;
   PreparedStatement pst=null;
   	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//reading parameters
		yourid=request.getParameter("yourid");
		yourname=request.getParameter("yourname");
		yourloc=request.getParameter("yourloc");
		yourip=request.getParameter("yourip");
		yourcomments=request.getParameter("yourcomments");
		 			
		try{
			//creating connection

			
    		connPool=(ConnectionPool)getServletContext().getAttribute("connPool");
			con=connPool.getConnection();
			String vsql="insert into eurtf_agents(agent_id,agent_name,location,ip_addr,comments) values(?,?,?,?,?)";
			pst=con.prepareStatement(vsql);
			pst.setString(1,yourid);
			pst.setString(2,yourname);
			pst.setString(3,yourloc);
			pst.setString(4,yourip);
			pst.setString(5,yourcomments);
			pst.executeUpdate();
			
			//forwarding to AgentAddPage with success message
			RequestDispatcher rd=request.getRequestDispatcher("AgentAddPage.jsp");
			request.setAttribute("success","success");
			rd.forward(request,response);
		
		}	
		catch(SQLException e)
		{	
			//getting error message
			String str=""+e.getErrorCode();
			
			//forwarding to AgentAddPage with failure message
			RequestDispatcher rd=request.getRequestDispatcher("AgentAddPage.jsp");
			request.setAttribute("error",str);
			rd.forward(request,response);
		}
		catch(Exception e)
		{
			RequestDispatcher rd=request.getRequestDispatcher("AgentAddPage.jsp");
			request.setAttribute("error","error");
			rd.forward(request,response);
		}		
		finally
		{	
			//releasing resources
			yourid=yourname=yourloc=yourip=yourcomments=null;
			try
			{
				connPool.free(con);
				pst.close();
			}
			catch(Exception e){}
			
		
		}  	
	
	 
	}
 
 
 }	
	