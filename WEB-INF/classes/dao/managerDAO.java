package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.manager;
import kobus_Interface.manager_Interface;

public class managerDAO implements manager_Interface{
	public manager ma;
	
	public manager get() {
		return ma;
	}
	
	public boolean managerLogin(String id, String pw) {

		boolean result = false;
		
		Kobus_Conn managercon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			conn = managercon.getConn();
			String sql = "select manager_id, manager_pw, manager_name from manager where manager_id=? and manager_pw=?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
				ma = new manager();
				ma.setM_id(rs.getString("manager_id"));
				ma.setM_pw(rs.getString("manager_pw"));
				ma.setM_name(rs.getString("manager_name"));
				
			}
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			managercon.close();
		}
		return result;
	}
}
