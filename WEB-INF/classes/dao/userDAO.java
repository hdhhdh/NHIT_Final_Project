package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.user;
import kobus_Interface.user_Interface;

public class userDAO implements user_Interface{
	public user ur;
	
	public user getUser() {
		return ur;
	}
	
	public boolean userLogin(String id, String pw) {
		// select  user;
		boolean result = false;
		
		Kobus_Conn usercon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			conn = usercon.getConn();
			String sql = "SELECT id, name, money, age, gender FROM user WHERE id=? and passwd=?;";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = true;
				ur = new user();
				
				ur.setU_id(rs.getString("id"));
				ur.setU_name(rs.getString("name"));
				ur.setU_money(rs.getInt("money"));
				ur.setU_age(rs.getInt("age"));
				ur.setU_gen(rs.getInt("gender"));
			}
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			usercon.close();
		}
		return result;
	}
	
	
	public boolean userSignUp(String id, String pw, String name, int age, int gender) {
		// insert
		boolean result =false;
		Kobus_Conn usercon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{	
			conn = usercon.getConn();
			String validSql = "Select id From user Where id=?;";
			pstmt = conn.prepareStatement(validSql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(!rs.next()) {
				String sql = "Insert into user(id, passwd, name, age, gender) values(?,?,?,?,?);";
				
				
				pstmt.clearParameters();
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				pstmt.setString(3, name);
				pstmt.setInt(4, age);
				pstmt.setInt(5, gender);
				pstmt.executeUpdate();
				
				result = true;
			}
			else {
				result = false;
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			usercon.close();
		}
		
		return result;
	}
	
	public void userPayment(String user_id, int pay) {
		// Update user;
		
		Kobus_Conn usercon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sql = "UPDATE user SET money=money+? WHERE id=?";
			conn = usercon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pay);
			pstmt.setString(2, user_id);
			if(pstmt.executeUpdate() == 1) {
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			usercon.close();
		}
	}
	
	public void userRefund(String user_id, int pay) {
		// update user;
		Kobus_Conn usercon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = pay/10 - pay;
		try
		{		
			String sql = "UPDATE user SET money=money+? WHERE id=?";
			conn = usercon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, re);
			pstmt.setString(2, user_id);
			if(pstmt.executeUpdate() == 1) {
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			usercon.close();
		}
	}
}
