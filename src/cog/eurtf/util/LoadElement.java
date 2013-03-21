/**
 * Author:O.K.Siva Murugan
 * Date:11/05/09
 * version:1.0
 * 
 * Author:Tamal Sen
 * Date:17/05/09
 * version:1.1
 * 
 */


package cog.eurtf.util;


//importing classes
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


public class LoadElement
{
	ArrayList auto_pop=null;
	ArrayList<String[]> res=null; 
	ArrayList<String> res1=null;
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	public LoadElement()
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
		
		
		try
		{	//creating connection
			Class.forName(driverString.trim());
			con=DriverManager.getConnection(connectionString.trim(),jdbcUser.trim(),jdbcPassword.trim());
			stmt = con.createStatement();
		}
		catch(Exception e)
		{	
			e.printStackTrace();
		}

	}


	public ArrayList fetchProjectDate(String projName)
	{
		res=new ArrayList<String[]>();
		String[] tempStr={"",""};
		try
		{
			String query="SELECT DATE_FORMAT(start_date,'%d-%m-%Y %H:%i:%S'),DATE_FORMAT(end_date,'%d-%m-%Y %H:%i:%S') FROM eurtf_monitoring_projects WHERE proj_name LIKE '"+projName+"'";
			ResultSet rs=con.createStatement().executeQuery(query);

			//retreiving startdate and enddate for	a given project			
			while(rs.next())
			{
				tempStr[0]=rs.getString(1);
				tempStr[1]=rs.getString(2);
				res.add(tempStr);
			}
		}
		catch(Exception e)
		{
			//releasing resources
			res=null;
		}
		return res;
	}


	public ArrayList fetchTransactionPair(String projName)
	{
		res=new ArrayList<String[]>();
		String[] tempStr={"",""};
		try
		{
			String query="SELECT a.agent_name,t.trans_name FROM eurtf_agents a,eurtf_transactions t,eurtf_monitoring_projects p WHERE a.agent_id=t.agent_id AND t.proj_id=p.proj_id AND p.proj_name LIKE '"+projName+"' GROUP BY t.trans_name,a.agent_name";
			ResultSet rs=con.createStatement().executeQuery(query);

			//retreiving agentname and transname for a project
			while(rs.next())
			{
				tempStr[0]=rs.getString(1);
				tempStr[1]=rs.getString(2);
				res.add(tempStr);
			}
		}
		catch(Exception e)
		{
			//releasing resources
			res=null;
		}
		return res;
	}

	public ArrayList fetchTransactionData(String str,String projName)
	{
		res1=new ArrayList<String>();
		String query=null;

		//to retreive unique transaction names
		if(str.equals("transaction"))
		{
			query="select distinct trans_name from eurtf_transactions t,eurtf_monitoring_projects p where t.proj_id=p.proj_id and p.proj_name LIKE '"+projName+"'";
		}

		//to retrieve unique project names
		else if(str.equals("project"))
		{
			query="select distinct p.proj_name from eurtf_transactions t,eurtf_monitoring_projects p where t.proj_id=p.proj_id order by p.proj_name";
		}

		//to retrieve unique agent names
		else if(str.equals("agent"))
		{
			query="select distinct a.agent_name from eurtf_transactions t,eurtf_agents a,eurtf_monitoring_projects p where t.agent_id=a.agent_id AND t.proj_id=p.proj_id AND p.proj_name LIKE '"+projName+"'";
			//System.out.println("MKMKMKMKMK:"+query);
		}

		//if given parameter does not match with required parameter
		else
			return null;

		try
		{
			rs=stmt.executeQuery(query);

			//to retreive data
			while(rs.next())
			{
				res1.add(rs.getString(1));
			}
		}
		catch(Exception e)
		{
			//releasing resources
			res1=null;
		}
		return res1;
	}





	public ArrayList fetch()
	{
		auto_pop=new ArrayList();
		try
		{	
			//to get project name from project table
			rs=stmt.executeQuery("select * from eurtf_monitoring_projects");

			//to store the data in an arraylist
			while(rs.next())
			{				
				auto_pop.add(rs.getString(2));
			}

		}
		catch(Exception e)
		{	
			auto_pop=null;
		}
		finally
		{
			//to release resources
			try
			{
				con.close();
				rs.close();
				stmt.close();
			}
			catch(Exception e)
			{				
			}
		}

		//returning the collected data


		return auto_pop;
	}
	
}


