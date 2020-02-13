package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dao.Kobus_Conn;
import dao.routeDAO;
import dto.manageDetail;
import dto.manageRoute;
import dto.route;
import dto.statistics_payment;
import dto.statistics_refund;

public class routeViewService {
	routeDAO rtD;
	ArrayList<route> arr_rt;
	ArrayList<String> start;
	ArrayList<String> end;
	ArrayList<manageRoute> manage_table = new ArrayList<manageRoute>();	
	ArrayList<manageDetail> detail_table = new ArrayList<manageDetail>();
	
	
	public routeViewService() {
		 rtD = new routeDAO();
		 arr_rt = rtD.selectRoute();
	}
	
	public route getRoute(int route_id) {
		route r = rtD.getRoute(route_id);
		return r;
	}
	
	public int searchId(String start, String end) {
		for(int i = 0; i<arr_rt.size(); i++) {
			if(start.equals(arr_rt.get(i).getRoute_start()) && end.equals(arr_rt.get(i).getRoute_end())){
				return arr_rt.get(i).getRoute_id();
			}
		}
		return 0;
	}
	
	public ArrayList<String> viewStart() {
		start = new ArrayList<String>();
		
		for(int i=0; i< arr_rt.size(); i++){
			if(!start.contains(arr_rt.get(i).getRoute_start()))
				start.add(arr_rt.get(i).getRoute_start());
		}
		return start;
	}
	
	public ArrayList<String> viewEnd(String startPoint) {
		end = new ArrayList<String>();
		
		for(int i=0; i< arr_rt.size(); i++){
			if(!end.contains(arr_rt.get(i).getRoute_end()) && 
					startPoint.equals(arr_rt.get(i).getRoute_start()))
				end.add(arr_rt.get(i).getRoute_end());
		}
		return end;
	}
	
	
	public ArrayList<manageRoute> make_table()	
	{
		Kobus_Conn make_table_con = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			String sql = "select route.start, route.end, bus.stat, count(bus.bus_id) as bus_c " + 
						 "from route join bus on route.route_id = bus.route_id " + 
						 "group by route.route_id, bus.stat;";
			conn = make_table_con.getConn();
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				manageRoute r = new manageRoute();
				r.setStart(rs.getString("route.start"));
				r.setEnd(rs.getString("route.end"));
				r.setGrade(rs.getInt("bus.stat"));
				r.setCount_bus(rs.getInt("bus_c"));

				manage_table.add(r);
			}
		}catch(SQLException se) {
			System.out.println("selectBusTime "+se.getMessage());
		}finally {
			make_table_con.close();
		}
		return manage_table;
	}
	
	public ArrayList<manageDetail> call_detail(int route_id, int bus_grade)	
	{
		Kobus_Conn detail_con = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			String sql = "select b.bus_id, b.time, b.bus_co, t.ticket_id AS tickets From bus b left outer join (Select bus_id, count(ticket_id) as ticket_id from ticket group by bus_id) t on b.bus_id=t.bus_id where b.route_id=? and b.stat=? group by b.bus_id;";

			conn = detail_con.getConn();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, route_id);
			pstmt.setInt(2, bus_grade);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				manageDetail r = new manageDetail();
				r.setB_id(rs.getInt(1));
				r.setS_time(rs.getString(2));
				r.setC_name(rs.getString(3));
				r.setT_count(rs.getInt(4));
				
				detail_table.add(r);
			}
		}catch(SQLException se) {
			System.out.println("selectBusTime "+se.getMessage());
		}finally {
			detail_con.close();
		}
		return detail_table;
	}
	
	public statistics_payment calc_payment(int route_id, String start_date, String end_date)	
	{				
		statistics_payment s = new statistics_payment();
		Kobus_Conn statistics_payment_con = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			String sql = "select count(*) as count, sum(payment) as sum from ticket where bus_id IN (Select bus_id from bus where route_id= ? and time between ? and ?);";
			
			conn = statistics_payment_con.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, route_id);
			pstmt.setString(2, start_date);
			pstmt.setString(3, end_date);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				s.setCount(rs.getInt("count"));
				s.setPayment(rs.getInt("sum"));

			}
			else {
				s.setCount(0);
				s.setPayment(0);
			}
		}catch(SQLException se) {
			System.out.println("selectBusTime "+se.getMessage());
		}finally {
			statistics_payment_con.close();
		}
		return s;
	}
	
	
	public statistics_refund calc_refund(int route_id, String start_date, String end_date)	
	{
		statistics_refund s = new statistics_refund();

		Kobus_Conn statistics_refund_con = new Kobus_Conn();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			
			String sql = "select count(*) as count, sum(refund) as sum from cancel where bus_id IN (Select bus_id from bus where route_id= ? and time between ? and ?);";
			
			conn = statistics_refund_con.getConn();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, route_id);
			pstmt.setString(2, start_date);
			pstmt.setString(3, end_date);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				s.setCount(rs.getInt("count"));
				s.setRefund(rs.getInt("sum"));
			}
			else {
				s.setCount(0);
				s.setRefund(0);
			}
		}catch(SQLException se) {
			System.out.println("selectBusTime "+se.getMessage());
		}finally {
			statistics_refund_con.close();
		}
		return s;
	}
	public void addBus(int r_id, String s_time, int b_grade, String c_name)   
	   {
	      Kobus_Conn addBus_con = new Kobus_Conn();
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try
	      {
	         String sql = "insert into bus(stat, start, route_id, bus_co) values(?, ?, ?, ?)";
	         conn = addBus_con.getConn();
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setInt(1, b_grade);
	         pstmt.setString(2, s_time);
	         pstmt.setInt(3, r_id);
	         pstmt.setString(4, c_name);
	         
	         pstmt.executeUpdate();
	         
	         if(pstmt != null) {
	            pstmt.close();
	         }
	         
	         if(conn != null)
	         {
	            conn.close();
	         }
	         
	      }catch(SQLException se) {
	         System.out.println("selectBusTime "+se.getMessage());
	      }finally {
	         addBus_con.close();
	      }
	   }
}
