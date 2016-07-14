<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<%
out.println("Entering Try block !!");
try{
	out.println("Registering Driver !!");
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = null;
	out.println("Getting the connection");
	//conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TEST","nikhil", "nikhilmone");
	//conn = DriverManager.getConnection("jdbc:mysql://mysqlservice/TEST","nikhil", "nikhilmone");
	Context ctx = new InitialContext();
	DataSource ds = (DataSource) ctx.lookup("java:jboss/datasources/myDS");
	conn = ds.getConnection();
	out.println("Got the connection");
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from employee");
	while(rs.next()){
		out.println(rs.getInt(1) + " - " + rs.getString(3));
	}
	conn.close();
	out.println("Closed the connection");
}catch(Exception ex){
	out.println("Entering Catch block !!");
	out.println(ex.getMessage());
}
%>
<body>

</body>
</html>