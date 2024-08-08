<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
    String logInIdx = (String) session.getAttribute("idx");
    boolean isLogined = false;
    if (logInIdx == null) {
        // 세션 미존재 시 페이지 접근 제한
        response.sendRedirect("../index.jsp");
        return;
    }
    
    session.invalidate();
%>

<script>
    location.href="../index.jsp"
    alert("성공적으로 로그아웃되었습니다")
</script>