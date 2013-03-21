/**
 * Author:Tamal Sen
 * Date:12/05/09
 * version:1.0
 *
 */

package cog.eurtf.util;

//importing classes
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.io.FileInputStream;
import java.io.Serializable;
import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;

public class ListElements {
	public static ArrayList load(String str)
	{
		
		
		
		/*************************Get database connection configurations from file**************************************/
		String driverString="";
		String connectionString="";
		String jdbcUser="";
		String jdbcPassword="";
		
		String path="./";

		FileInputStream fis;
		try {
			fis = new FileInputStream(path+"data_source.conf");
			
			int i=0;
			char c;
			char temp[]=new char[100];
			while((c=(char)fis.read())!='\n'){
				temp[++i]=c;
			}
			driverString=new String(temp);
			i=0;
			temp=new char[100];
			while((c=(char)fis.read())!='\n'){
				temp[++i]=c;
			}
			connectionString=new String(temp);

			i=0;
			temp=new char[100];
			while((c=(char)fis.read())!='\n'){
				temp[++i]=c;
			}
			jdbcUser=new String(temp);
			
			i=0;
			temp=new char[100];
			while((c=(char)fis.read())!='\n'){
				temp[++i]=c;
			}
			jdbcPassword=new String(temp);
			
			fis.close();
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		/**********************************************************************************************************/
		
		
		ArrayList LB=new ArrayList();
		Connection con=null;
		ResultSet rs=null;
		Statement stmt=null;
		
		try
		{
			//creating connection
			Class.forName(driverString.trim());
			con=DriverManager.getConnection(connectionString.trim(),jdbcUser.trim(),jdbcPassword.trim());
			stmt = con.createStatement();
			if(str.equals("ReqAgents"))
			{
				rs=stmt.executeQuery("select * from eurtf_agents where proj_id is null");
				while(rs.next())
				{
					LB.add(rs.getString(2));
				}
			}
			else
			{
				rs=stmt.executeQuery("select * from eurtf_agents where proj_id='"+str+"'");
				while(rs.next())
				{
					LB.add(rs.getString(2));
				}
			}
		}
		catch(Exception e){}
		
		finally
		{
			//releasing resources
			try
			{
				stmt.close();
				rs.close();
				con.close();
			}
			catch(Exception e)
			{}
		}
		
	//returning the data
	return LB;
}
}