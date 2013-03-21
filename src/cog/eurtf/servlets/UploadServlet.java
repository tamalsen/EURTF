package cog.eurtf.servlets;
/**
 * Author:Tamal Sen
 * Date:12/05/09
 * version:1.0
 *
 */

//class import
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import cog.eurtf.jdbc.ConnectionPool;
import cog.eurtf.util.FileParser;

import com.oreilly.servlet.MultipartRequest;



/**
 * Servlet implementation class for Servlet: UploadServlet
 *
 */

public class UploadServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	Connection con=null;
	ConnectionPool connPool=null;
	ResultSet rs=null;
	Statement stmt=null;
	String dFile,iFile,agent,project,tname,pFile;
	static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		PrintWriter out=response.getWriter();
		MultipartRequest mr=null;
		try{

			String path = getServletContext().getRealPath("/");
			//path="/EURTF/";
			//System.out.println(path);
			mr=new MultipartRequest(request,path+"upload");

			//reading parameters
			agent=mr.getParameter("agent");
			project=mr.getParameter("project");
			tname=mr.getParameter("TName");
			dFile=mr.getFile("myFile").toString(); //gets data file name stored in server
			iFile=mr.getFile("myFile1").toString();//gets image file name stored in server
			Enumeration obj=mr.getFileNames();
			pFile=mr.getFile("myFile").getAbsolutePath().toString();




			FileParser fp=new FileParser();

			//calling FileParser() function to parse the uploaded file
			ArrayList get_detail=fp.parse(pFile);

			if(get_detail.size()==6)
			{
				float d[]=new float[4];

				//for loop to convert the arraylist value to float
				for(int i=0;i<4;i++)
				{	
					d[i]=Float.valueOf(get_detail.get(i).toString()).floatValue();
				}


				//creating connection
				connPool=(ConnectionPool)getServletContext().getAttribute("connPool");
				con=connPool.getConnection();
				stmt = con.createStatement();

				//System.out.println(iFile);
				try
				{	
					//to get corresponding agent id for selected agentname
					rs=stmt.executeQuery("select * from eurtf_agents where agent_name='"+agent+"'");
					rs.next();
					agent=rs.getString(1);

					//to get corresponding project id for selected projectname
					rs=stmt.executeQuery("select * from eurtf_monitoring_projects where proj_name='"+project+"'");
					rs.next();
					project=rs.getString(1);

				}
				catch(Exception e)
				{
					//e.printStackTrace();
					throw new Exception();
				}

				//System.out.println(get_detail.get(5));
				String date_str=String.valueOf(get_detail.get(5));

				//inserting values into transaction table
				//stmt.executeQuery("insert into eurtf_transactions values(eurtf_trans_id.nextval,'"+tname+"','"+agent+"','"+project+"',"+d[0]+","+d[1]+","+d[2]+",'"+dFile+"','"+iFile+"',TO_DATE('"+date_str+"','DD-MM-YYYY:HH24:MI:SS')+(19800/86400))");
				stmt.executeUpdate("insert into eurtf_transactions(trans_name,agent_id,proj_id,page_load_time,time_to_first_byte,time_to_start_render,time_to_fully_loaded,ifile_url,dfile_url,trans_date) values('"+tname+"','"+agent+"','"+project+"',"+d[0]+","+d[1]+","+d[2]+","+d[3]+",'"+iFile+"','"+dFile+"',STR_TO_DATE('"+date_str+"','%d-%M-%Y %H:%i:%S'))");

				d=null;
				get_detail=null;

				/*************************RENAME THE FILES*******************************/
				//mr.getFile("myFile").renameTo(new File("page_load_details_"+(new java.util.Date())+".txt"));
				/***********************************************************************/
				
				//for dispatching request back to jsp with success message
				RequestDispatcher rd=request.getRequestDispatcher("PageTestParser.jsp");
				request.setAttribute("success","success");
				rd.forward(request,response);
			}
			else
			{
				throw new Exception();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			//for dispatching request back to jsp with error message
			RequestDispatcher rd=request.getRequestDispatcher("PageTestParser.jsp");
			request.setAttribute("error","error");
			rd.forward(request,response);
		}
		finally
		{

			//releasing the resources
			try{
				dFile=iFile=agent=project=tname=pFile=null;
				connPool.free(con);
				rs.close();
				stmt.close();
			}
			catch(Exception e)
			{}
		}

	}

}   	  	    