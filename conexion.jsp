<%@page language="java" import="java.sql.*"%>
<%
    Connection conexion = null;
    PreparedStatement st = null;
    ResultSet rs = null;

    Class.forName("com.mysql.jdbc.Driver");
    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/kumon_ia", "root", "");
%>