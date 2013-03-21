/**
 * Author:O.K.Siva Murugan
 * Date:13/05/09
 * version:1.0
 *
 * Author:O.K.Siva Murugan
 * Date:15/05/09
 * version:1.1
 * 
 */


package cog.eurtf.util;

//impoting classes
import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;


public class FileParser {
	public ArrayList parse(String str)
	{
    	FileInputStream fis = null;
        BufferedInputStream bis = null;
        DataInputStream dis = null;
        ArrayList res=null;
        File file = new File(str);
               
        try {
        	//creating input stream object to read a file
        	fis = new FileInputStream(file);
        	bis = new BufferedInputStream(fis);
        	dis = new DataInputStream(bis);
        	res=new ArrayList();
        	String s;
        	
        	//read every line till "request 2:" is encountered
        	while ((s=dis.readLine()).equals("Request 2:")!=true)
        	{	 
        		//split the string when ":" is encountered
        		StringTokenizer st = new StringTokenizer(s,":");
    	 
        		//read the tokens
        		while(st.hasMoreTokens())
        		{ 
        			String chk=st.nextToken().trim();
        			
        			//To get page load time
        			if(chk.equals("Page load time"))
        			{
        				String ab=st.nextToken().trim();
        				StringTokenizer st1 = new StringTokenizer(ab," ");
        				res.add(st1.nextToken());
        				ab=null;
        				st1=null;
        				break;
        			}
        			
        			//To get Time to first byte
        			else if(chk.equals("Time to first byte"))
        			{
        				String ab=st.nextToken().trim();
        				StringTokenizer st1 = new StringTokenizer(ab," ");
        				res.add(st1.nextToken());
        				ab=null;
        				st1=null;
        				break;
        			}
        			       			
        			
        			//To get Time to Start Render
        			else if(chk.equals("Time to Start Render"))
        			{
        				String ab=st.nextToken().trim();
        				StringTokenizer st1 = new StringTokenizer(ab," ");
        				//System.out.println(st1.nextToken());
        				res.add(st1.nextToken());
        				ab=null;
        				st1=null;
        				break;
    		   			
        			}
        			
        			
        			//To get Time to fully loaded
        			else if(chk.equals("Time to Fully Loaded"))
        			{
        				String ab=st.nextToken().trim();
        				StringTokenizer st1 = new StringTokenizer(ab," ");
        				res.add(st1.nextToken());
        				ab=null;
        				st1=null;
        				break;
        			}
        			
        			
        			//To get the Date
        			else if(chk.equals("Date"))
        			{
        				String ab=st.nextToken().trim();
        				StringTokenizer st1=new StringTokenizer(ab,",");
        				st1.nextToken();
        				String ab1=st1.nextToken();
        				StringTokenizer st2=new StringTokenizer(ab1," ");
        				String dat1=st2.nextToken();
        				String dat2=st2.nextToken();
        				String dat3=st2.nextToken();
        				String date=dat1+"-"+dat2+"-"+dat3;
        				String time=st2.nextToken();
        				String t1=st.nextToken();
        				String t2=st.nextToken();
        				StringTokenizer st3=new StringTokenizer(t2," ");
        				String t3=st3.nextToken();
        				time=time+":"+t1+":"+t3;
        				//date=date+":"+time;
        				date=date+" "+time;
        				res.add(date);
        				ab=ab1=dat1=dat2=dat3=date=time=t1=t2=t3=null;
        				st1=st2=st3=null;
        				break;
        			}
        			
        			    			
        			//To skip if they are not encountered
        			else
        			{
        				continue;
        			}
    		
    	  }
      }
    }
    catch (FileNotFoundException e) 
    {
      e.printStackTrace();
    }
    catch (IOException e) 
    {
      e.printStackTrace();
    }
    finally
    {	
    	//to release resources
    	try
    	{
    	fis.close();
   	  	bis.close();
   	  	dis.close();
   	  	file=null;
    	}
    	catch(Exception e){}
    }
    
    return res;

}
}
