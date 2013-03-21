package cog.eurtf.chart; 
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


public class GenerateXML {

	Connection con;
	private String oXMLFile="";
	private String oJSFile="";
	
	public GenerateXML(Connection con,String oXMLFile,String oJSFile){
		this.con=con;
		this.oXMLFile=oXMLFile;
		this.oJSFile=oJSFile;
	}
	
	
	public int generate(String queryString) {
		Statement stmt;
		ResultSet rs=null;
		StringBuffer JSbuff=new StringBuffer();
		
		
		try {
			stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs=stmt.executeQuery(queryString);
			if(rs==null){
				System.out.println("rs null");
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		File f=new File(oXMLFile);
		//System.out.println(f.getAbsolutePath());
		int dataFound=0;
		
		
		try {
			OutputStream os=new FileOutputStream(f);
			OutputStream os1=new FileOutputStream(oJSFile);
			
			try {
				os.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n".getBytes());
				os.write("<chart>\n".getBytes());
				os.write("<graphs>\n".getBytes());
				int transCount=0;
				
				String prevTrans;
				String currentTrans;
				String transDate;
				int pageLoadTime;
				String imageUrl;
				String colors[]={"#7F4E52","#F9B7FF","#4CC417","#C9BE62","#F9966B","#FFF8C6","#7F525D"};
				
				JSbuff.append("function ss(){\n");
				JSbuff.append("flashMovie.setSettings(\"");
				JSbuff.append("<settings><graphs>");

				while(rs.next()){
					
					JSbuff.append("<graph gid=\\\""+transCount+"\\\"><title>"+rs.getString("TRANS_NAME")+"</title><color>"+colors[transCount%colors.length]+"</color><balloon_text><![CDATA[<b>DATE: </b>{x}<b><br>PAGE LOAD TIME: </b>{y}ms<br><center>Click to see details]]></balloon_text><bullet>square_outlined</bullet></graph>");
					
					os.write(("<graph gid=\""+transCount+"\">\n").getBytes());
					
					transCount++;
					while(true){
						
						dataFound++;
						transDate=rs.getString("TRANS_DATE");
						pageLoadTime=(int)(rs.getFloat("TIME_TO_FULLY_LOADED")*1000);
						imageUrl="javascript:popup('WaterfallDetails.jsp?trans_name="+rs.getString("TRANS_NAME")+"&ifile="+rs.getString("IFILE_URL")+"&agent_name="+rs.getString("AGENT_NAME")+"')";
						os.write(("<point x=\""+transDate+"\" y=\""+pageLoadTime+"\"  url=\""+imageUrl+"\"></point>\n").getBytes());
						
						prevTrans=rs.getString("TRANS_NAME");
						boolean flag=rs.next();
						if(!flag || !prevTrans.equals(currentTrans=rs.getString("TRANS_NAME"))){
							if(flag)
								rs.previous();
							break;
						}
					}
					os.write("</graph>\n".getBytes());	
					
				}
				JSbuff.append("</graphs></settings>");
				JSbuff.append("\");");
				JSbuff.append("\n}");
				os1.write(JSbuff.toString().getBytes());
				os1.close();
				//System.out.println(JSbuff.toString());
				os.write("</graphs>\n".getBytes());
				os.write("</chart>\n".getBytes());
				os.close();
				//System.out.println("CHART DONE");
			} catch (Exception e) {
				e.printStackTrace();
				return -1;
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return -1;
		}
		
			return dataFound;
			
	}

}


