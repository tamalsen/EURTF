package cog.eurtf.requester;
import java.io.*;
import java.net.*;
import java.util.Scanner;


public class Requester{
	Socket requestSocket;
	ObjectOutputStream out;
	ObjectInputStream in;
	String message;
	String ip;
	int port;
	public Requester(String ip,int port){
		this.ip=ip;
		this.port=port;
	}


	public boolean ping()
	{
		try {
			requestSocket = new Socket(ip, port);
			requestSocket.close();
			return true;
		} catch (UnknownHostException e) {
			return false;
		} catch (IOException e) {
			return false;
		}
	}
	
	
	
public void run()
	{
		try{
			//1. creating a socket to connect to the server
			//requestSocket = new Socket("pc010616", 2004);
			requestSocket = new Socket(ip, port);
			System.out.println("Connected to "+ip+" in port "+port);
			//2. get Input and Output streams
			out = new ObjectOutputStream(requestSocket.getOutputStream());
			out.flush();
			in = new ObjectInputStream(requestSocket.getInputStream());
			//3: Communicating with the server
			do{
				try{
					message = (String)in.readObject();
					System.out.println("server>" + message);
					sendMessage("start");
					message = "bye";
					boolean b=true;
					Scanner sc=new Scanner(System.in);


					while(b){
						message=sc.nextLine();
						sendMessage(message);
					}
					sendMessage(message);
				}
				catch(ClassNotFoundException classNot){
					System.err.println("data received in unknown format");
				}
			}while(!message.equals("bye"));
		}
		catch(UnknownHostException unknownHost){
			System.err.println("You are trying to connect to an unknown host!");
		}
		catch(IOException ioException){
			ioException.printStackTrace();
		}
		finally{
			//4: Closing connection
			try{
				in.close();
				out.close();
				requestSocket.close();
			}
			catch(IOException ioException){
				ioException.printStackTrace();
			}
		}
	}

	
	
	/*public void run()
	{
		try{
			//1. creating a socket to connect to the server
			//requestSocket = new Socket("pc010616", 2004);
			requestSocket = new Socket(ip, port);
			System.out.println("Connected to "+ip+" in port "+port);
			//2. get Input and Output streams
			out = new ObjectOutputStream(requestSocket.getOutputStream());
			out.flush();
			in = new ObjectInputStream(requestSocket.getInputStream());
			//3: Communicating with the server
		}
		catch(UnknownHostException unknownHost){
			System.err.println("You are trying to connect to an unknown host!");
		}
		catch(IOException ioException){
			ioException.printStackTrace();
		}
		
	}*/
	public void sendMessage(String msg)
	{
		try{
			out.writeObject(msg);
			out.flush();
			System.out.println("client>" + msg);
		}
		catch(IOException ioException){
			ioException.printStackTrace();
		}
	}

	public void close(){
		try{
			in.close();
			out.close();
			requestSocket.close();
		}
		catch(IOException ioException){
			ioException.printStackTrace();
		}
		
	}
	public static void main(String args[])
	{
		Requester client = new Requester("localhost",2004);
		client.run();
	}
}
