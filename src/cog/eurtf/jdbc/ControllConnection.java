package cog.eurtf.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;


import javax.servlet.*;

public  class ControllConnection implements ServletContextListener {
	ConnectionPool connPool;
	private ServletContext context = null;

	public void contextInitialized(ServletContextEvent event)
	{
		this.context =event.getServletContext();
		System.out.println("CREATING CONNECTION POOL!");
		try {
			connPool=new ConnectionPool("oracle.jdbc.driver.OracleDriver","jdbc:oracle:thin:@pc028021:1521:ora7","scott","tiger",10,20,false);
			context.setAttribute("connPool", connPool);
		}
		catch (Exception e) {	
			System.out.println("Exception setting attribute"+e.getMessage());
		} 
		System.out.println("The mCVW Server Is Ready");

	}


	public void contextDestroyed(ServletContextEvent event)
	{
		this.context =event.getServletContext();
		connPool.closeAllConnections();
		context.removeAttribute("connPool");
		System.out.println("MCVW Server Shutting Down");
	}
}