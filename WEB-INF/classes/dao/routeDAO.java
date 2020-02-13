package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.route;
import kobus_Interface.route_Interface;

public class routeDAO implements route_Interface{
	

	public route getRoute(int route_id) {
		route r = new route();
		
		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{		
			String sql = "Select * from route where route_id = ?;";
			conn = Buscon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, route_id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				r.setRoute_id(rs.getInt("route_id"));
				r.setRoute_start(rs.getString("start"));
				r.setRoute_end(rs.getString("end"));
				r.setRoute_time(rs.getString("route_time"));
				r.setRoute_price(rs.getInt("price"));
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			Buscon.close();
		}
		return r;
	}
	
	
	public void selectManagerRoute() {

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
	
	public ArrayList<route> selectRoute() {

		Kobus_Conn Buscon = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<route> route = new ArrayList<route>();
		
		try
		{		
			String sql = "SELECT * FROM route";
			conn = Buscon.getConn();
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				route rt = new route();
				rt.setRoute_id(rs.getInt("route_id"));
				rt.setRoute_start(rs.getString("start"));
				rt.setRoute_end(rs.getString("end"));
				rt.setRoute_price(rs.getInt("price"));
				
				route.add(rt);
			}
			
		}catch(SQLException se) {
			System.out.println(se.getMessage());
		}finally {
			try {
				rs.close();
				pstmt.close();
				Buscon.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return route;
	}
}
