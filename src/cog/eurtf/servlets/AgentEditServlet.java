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
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cog.eurtf.jdbc.ConnectionPool;


public class AgentEditServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet 
{
   static final long serialVersionUID = 1L;
   String yourid;
   String yourname;
   String yourip;
   String yourloc;
   String yourcomments;
   String up_id;
   Connection con=null;
   ConnectionPool connPool=null;
   PreparedStatement pst=null;
  
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
   {
	   //reading parameters
	   up_id=request.getParameter("up_id");
	   yourid=request.getParameter("yourid");
	   yourname=request.getParameter("yourname");
	   yourloc=request.getParameter("yourloc");
	   yourip=request.getParameter("yourip");
	   yourcomments=request.getParameter("yourcomments");
	   
	   try
	   {
		   //creating connection
   		connPool=(ConnectionPool)getServletContext().getAttribute("connPool");
		con=connPool.getConnection();
			String vsql="update eurtf_agents set agent_id=?, agent_name=?,location=?,ip_addr=?,comments=? where agent_id='"+up_id+"'";
			pst=con.prepareStatement(vsql);
			pst.setString(1,yourid);
			pst.setString(2,yourname);
			pst.setString(3,yourloc);
			pst.setString(4,yourip);
			pst.setString(5,yourcomments);
			pst.executeUpdate();
			
			//forwarding to AgentEditPage with success message
			RequestDispatcher rd=request.getRequestDispatcher("AgentViewPage.jsp");
			request.setAttribute("success","successup");
			rd.forward(request,response);
		
		
		}
	   catch(SQLException e)
		{	
			//getting error message
			String str=""+e.getErrorCode();
			
			//forwarding to AgentAddPage with failure message
			RequestDispatcher rd=request.getRequestDispatcher("AgentViewPage.jsp");
			request.setAttribute("error",str);
			rd.forward(request,response);
		}
		catch(Exception e)
		{
			RequestDispatcher rd=request.getRequestDispatcher("AgentViewPage.jsp");
			request.setAttribute("error","errorup");
			rd.forward(request,response);
		}		
		
	   finally
	   {
		   //releasing resources
		   yourid=yourname=yourloc=yourip=yourcomments=up_id=null;
		   try
		   {
			connPool.free(con);
			pst.close();
		   }
		   catch(Exception e){}
		
		
	   }  	
			 
   }
}   	  	    
