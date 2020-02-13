<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.Kobus_Conn"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="service.routeViewService"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%	
	Kobus_Conn kc = new Kobus_Conn();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Connection conn = null;
	try{
		conn = kc.getConn();
		//Class.forName("com.mysql.jdbc.Driver");
		
		//conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kobus","kobus","apmsetup");
		String sql = "insert into user values('rrrr', 'rrrr', '기천', 1,1,1);";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
	}
	catch(Exception e){
		out.println(e.getMessage());
	}

	try{
		routeViewService rvs = new routeViewService();

		ArrayList<String> start = rvs.viewStart();
		for(int i=0; i<start.size(); i++){
			out.println(start.get(i));
		}
	}catch(Exception e){
		out.println(e.getMessage());
		}
%>

</body>
</html>
