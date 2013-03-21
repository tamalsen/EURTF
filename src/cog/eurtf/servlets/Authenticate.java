package cog.eurtf.servlets;

/**
 * Author:O.K.Siva Murugan
 * Date:09/05/09
 * version:1.0
 * 
 * Author:O.K.Siva Murugan
 * Date:10/05/09
 * version:1.1
 * 
 * Author:Tamal Sen
 * Date:10/05/09
 * version:1.2
 *
 */

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cog.eurtf.jdbc.ConnectionPool;


public class Authenticate extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ConnectionPool connPool;
	String user;
	String pass;
	boolean waitIfBusy;
    static final long serialVersionUID = 1L;
    
    @Override
    public void init(){
    	System.out.println("CREATING CONNECTION POOL!");
    	try {
    		String driverString=getServletContext().getInitParameter("jdbcDriver");
    		String connectionString=getServletContext().getInitParameter("jdbcConnectionURL");
    		String jdbcUser=getServletContext().getInitParameter("jdbcUser");
    		String jdbcPassword=getServletContext().getInitParameter("jdbcPassword");
    		String path = getServletContext().getRealPath("/");
    		path="./";
    		FileOutputStream fos=new FileOutputStream(path+"data_source.conf");
    		fos.write(driverString.getBytes());
    		fos.write('\n');
    		fos.write(connectionString.getBytes());
    		fos.write('\n');
    		fos.write(jdbcUser.getBytes());
    		fos.write('\n');
    		fos.write(jdbcPassword.getBytes());
    		fos.write('\n');

    		fos.close();
    		
    		
    		ConnectionPool connPool=new ConnectionPool(driverString,connectionString,jdbcUser,jdbcPassword,10,20,waitIfBusy);
			ServletContext context=getServletContext();
			context.setAttribute("connPool", connPool);
			System.out.println("CONNECTION POOL CREATED!");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("CONNECTION POOL CREATION FAILD...!");
			this.destroy();
		}
		finally{
			
		}
	   
    }
    public void destroy(){
		ServletContext context=getServletContext();
		ConnectionPool pool=(ConnectionPool)context.getAttribute("connPool");
		if(pool!=null){
			pool.closeAllConnections();
		}
    	
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
/*    	File f=new File("./");
    	System.out.println("FILE PATH::::"+f.getAbsolutePath());
*/		user=request.getParameter("uname");
		pass=request.getParameter("password");
	
		try
		{
			//creating connection
    		connPool=(ConnectionPool)getServletContext().getAttribute("connPool");
			con=connPool.getConnection();
			stmt = con.createStatement();
			rs=stmt.executeQuery("select * from eurtf_users");
			
			//to get data from database
			while(rs.next())
			{	
				//check username and password with data from database
				if(user.equals(rs.getString(1))&&pass.equals(rs.getString(2)))
				{
					//checking for privilages
					if(rs.getString(3).equals("A"))
					{
						//forwarding to admin page 
						HttpSession session=request.getSession(true);
						session.setMaxInactiveInterval(600);
						session.setAttribute("user", user);
						session.setAttribute("priv", "A");
						response.sendRedirect("AdminPage.jsp");
					}
					
					//checking for privilages
					else
					{	//forwarding to user page
						HttpSession session=request.getSession(true);
						session.setMaxInactiveInterval(600);
						session.setAttribute("user", user);
						session.setAttribute("priv", "U");
						response.sendRedirect("UserPage.jsp");

					}
				}
			}	
			
			//forward to login page if user does not exist
			RequestDispatcher rd=request.getRequestDispatcher("Login.jsp");
			request.setAttribute("error","error");
			rd.forward(request,response);
		}
		catch(Exception e){
			response.getWriter().print("AN EXCEPTION OCCOURED WHILE LOGGING IN......please <a href=\"Login.jsp\">TRY AGAIN</a><br>");
			
		}
		finally
		{
			//releasing resources
			try
			{
				user=null;
				pass=null;
				stmt.close();
				rs.close();
				connPool.free(con);
			}
			
			catch(Exception e)
			{
				response.getWriter().print("AN EXCEPTION OCCOURED WHILE LOGGING IN......please <a href=\"Login.jsp\">TRY AGAIN</a>");
			}
		}
		
	
    }   	  	    
}