package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.bus;
import kobus_Interface.bus_Interface;

public class busDAO implements bus_Interface{
	
	public ArrayList<bus> selectBusTime(int route_id) {

		ArrayList<bus> temp = new ArrayList<bus>();
		
		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			String sql = "select * from bus where route_id = ? order by time;";
			conn = Buscon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, route_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				bus b = new bus();
				b.setBus_id(rs.getInt("bus_id"));
				b.setBus_stat(rs.getInt("stat"));
				b.setBus_start(rs.getString("time"));
				b.setBus_co(rs.getString("bus_co"));
				temp.add(b);
			}
		}catch(SQLException se) {
			System.out.println("selectBusTime "+se.getMessage());
		}finally {
			Buscon.close();
		}
		return temp;
	}
	
	public void addBus() {

		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sql = "";
			conn = Buscon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
	}
	
	public void countBus() {

		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sql = "";
			conn = Buscon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
	}

	public void selectManageBus() {

		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sql = "";
			conn = Buscon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
	}
}
