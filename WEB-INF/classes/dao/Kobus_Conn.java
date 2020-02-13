package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class Kobus_Conn {

	public static Connection conn = null;

	public Kobus_Conn(){
		
	}
	public static Connection getConn() {
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kobus?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8", "kobus", "apmsetup");

		}catch(ClassNotFoundException cnfe) {
			System.out.println("classError." + cnfe.getMessage());
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}
		return conn;
	}
	
	public static void close() {
		if(conn != null) {
			try {
				if(!conn.isClosed())
					conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		conn = null;
	}
}
