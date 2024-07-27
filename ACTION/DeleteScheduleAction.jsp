<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    String idx = request.getParameter("idx");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    request.setCharacterEncoding("utf-8");
    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
%>

<script>
    alert("일정이 삭제되었습니다.")
    location.href="../PAGE/SelectSchedulePage.jsp?key=0" + "&year=<%=year%>" + "&month=<%=month%>" + "&day=<%=day%>"
</script>