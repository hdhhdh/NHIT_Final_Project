package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBTransaction {
	
	public void transaction() {
		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sql = "Start Transaction;";
			conn = Buscon.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.execute();
			
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
	}
	
	public void commit() {

		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sql = "commit;";
			conn = Buscon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.execute();
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
	}
	
}
