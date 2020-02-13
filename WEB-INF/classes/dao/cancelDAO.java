package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.myCancel;
import dto.ticket;
import kobus_Interface.cancel_Interface;

public class cancelDAO implements cancel_Interface{
	
	
	public ArrayList<myCancel> selectUserCancel(String user_id) {
		
		ArrayList<myCancel> can = new ArrayList<myCancel>();
		
		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sqls = "SELECT route.start, route.end, bus.time, bus.stat,  bus.bus_co, cancel.refund, cancel.seat_num, cancel.cancel_time  "
					+ "FROM bus JOIN route ON bus.route_id = route.route_id JOIN cancel ON bus.bus_id = cancel.bus_id "
					+ "WHERE user_id=? "
					+ "ORDER BY cancel.cancel_time DESC;";
			conn = Buscon.getConn();
			pstmt = conn.prepareStatement(sqls);
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				myCancel c = new myCancel();
				c.setR_start(rs.getString("route.start"));
				c.setR_end(rs.getString("route.end"));
				c.setBus_time(rs.getString("bus.time"));
				c.setBus_stat(rs.getInt("bus.stat"));
				c.setBus_co(rs.getString("bus.bus_co"));
				c.setCancel_seat(rs.getInt("cancel.seat_num"));
				c.setCancel_ref(rs.getInt("cancel.refund"));
				c.setCancel_time(rs.getString("cancel.cancel_time"));
				
				can.add(c);
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
		return can;
	}
	
	public void addCancel(String user_id, ticket tic) {

		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rs;
		try
		{		
			String sql = "Insert into cancel(bus_id, seat_num, user_id, refund) values(?,?,?,?);";
			conn = Buscon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, tic.getBus_id());
			pstmt.setInt(2, tic.getSeat_num());
			pstmt.setString(3, user_id);
			pstmt.setInt(4, tic.getPayment()/10);
			
			rs = pstmt.executeUpdate();
			if(rs == 1) {
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
	}
	
	public void countCancel() {

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
