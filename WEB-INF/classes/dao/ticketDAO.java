package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import dto.myTickets;
import dto.ticket;
import kobus_Interface.ticket_Interface;

public class ticketDAO implements ticket_Interface{
	
	public boolean validTicket(int bus_id, String[] seat_num) {
		boolean result = false;
		
		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{	
			String sql = "SELECT ticket_id FROM ticket WHERE bus_id=? and seat_num IN(?);";
			int[] nums = Arrays.stream(seat_num).mapToInt(Integer::parseInt).toArray();
			String sub = "";
			
			for(int i=0; i<nums.length; i++) {
				sub += nums[i];
				if(i != nums.length-1) sub += ", ";
			}
			
			
			conn = Buscon.getConn();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bus_id);
			pstmt.setString(2, sub);
			rs = pstmt.executeQuery();
			
			if(!rs.next()) {
				result = true;
			}
			
		}catch(SQLException se) {
			System.out.println("err"+se.getMessage());
		}finally {
			Buscon.close();
		}
		
		return result;
	}
	
	public void addTicket(int bus_id, String[] seat_num, String user_id, String[] prices) {
		// Insert Ticket;

		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{	
			String sql = "INSERT into ticket(bus_id, seat_num, user_id, payment) VALUES(?,?,?,?);";
			
			conn = Buscon.getConn();
			pstmt = conn.prepareStatement(sql);
			
			
			for(int i=0; i<seat_num.length;i++) {
				pstmt.setInt(1, bus_id);
				pstmt.setInt(2, Integer.parseInt(seat_num[i]));
				pstmt.setString(3, user_id);
				pstmt.setInt(4, Integer.parseInt(prices[i]));
				pstmt.executeUpdate();
				pstmt.clearParameters();
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
	}
	
	public void countTicket() {
		// select count(ticket_id) & select sum(payment)
		

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
	
	public ticket deleteTicket(int ticket_id) {
		// delete ticket
		ticket tic = new ticket();
		
		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sql = "SELECT * FROM ticket WHERE ticket_id = ?";
			conn = Buscon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ticket_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				tic.setTicket_id(rs.getInt("ticket_id"));
				tic.setBus_id(rs.getInt("bus_id"));
				tic.setSeat_num(rs.getInt("seat_num"));
				tic.setPayment(rs.getInt("payment"));
				pstmt.clearParameters();
				
				sql = "DELETE FROM ticket WHERE ticket_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ticket_id);
				pstmt.executeUpdate();
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
		
		return tic;
	}
	
	public ArrayList<ticket> selectTicket(int bus_id) {
		// select ticket
		
		ArrayList<ticket> tic = new ArrayList<ticket>();
		
		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sql = "SELECT ticket_id, seat_num FROM ticket WHERE bus_id=?";
			conn = Buscon.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bus_id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ticket t = new ticket();
				t.setTicket_id(rs.getInt("ticket_id"));
				t.setSeat_num(rs.getInt("seat_num"));
				
				tic.add(t);
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
		return tic;
	}

	public ArrayList<myTickets> selectUserTicket(String user_id) {
		// select ticket
		
		ArrayList<myTickets> tic = new ArrayList<myTickets>();
		
		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sqls = "SELECT route.start, route.end, bus.time, bus.stat,  bus.bus_co, ticket.payment, ticket.seat_num, ticket.ticketing_time, ticket.ticket_id "
					+ "FROM bus JOIN route ON bus.route_id = route.route_id JOIN ticket ON bus.bus_id = ticket.bus_id "
					+ "WHERE user_id=? "
					+ "ORDER BY ticket.ticketing_time DESC;";
			conn = Buscon.getConn();
			pstmt = conn.prepareStatement(sqls);
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				myTickets t = new myTickets();
				t.setR_start(rs.getString("route.start"));
				t.setR_end(rs.getString("route.end"));
				t.setBus_time(rs.getString("bus.time"));
				t.setBus_stat(rs.getInt("bus.stat"));
				t.setBus_co(rs.getString("bus.bus_co"));
				t.setTicket_seat(rs.getInt("ticket.seat_num"));
				t.setTicket_pay(rs.getInt("ticket.payment"));
				t.setTicket_id(rs.getInt("ticket.ticket_id"));
				t.setTicket_time(rs.getString("ticket.ticketing_time"));
				
				tic.add(t);
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
		return tic;
	}
}
