package cog.eurtf.servlets;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cog.eurtf.jdbc.ConnectionPool;



 public class LoadAgent extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
  
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
   {
	ConnectionPool connPool=null;
	Connection con=null;
	String pname=request.getParameter("proj_name");
	ArrayList auto_pop=new ArrayList();
	try{	
		//creating connection
		connPool=(ConnectionPool)getServletContext().getAttribute("connPool");
		con=connPool.getConnection();		Statement stmt = con.createStatement();
		ResultSet rs=stmt.executeQuery("select * from eurtf_agents where proj_id=(select proj_id from eurtf_monitoring_projects where proj_name like '"+pname+"')");
		
		while(rs.next())
		{					
			auto_pop.add(rs.getString(2));
		}
		
		RequestDispatcher rd=request.getRequestDispatcher("AutoPopAgent.jsp");
		request.setAttribute("retname", auto_pop);
		rd.forward(request, response);
	}
	catch(Exception e)
	{}
	finally{
		connPool.free(con);
	}
		
   }   	  	    
}