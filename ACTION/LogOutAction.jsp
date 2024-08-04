<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
    session.invalidate();
%>

<script>
    location.href="../index.jsp"
    alert("성공적으로 로그아웃되었습니다")
</script>