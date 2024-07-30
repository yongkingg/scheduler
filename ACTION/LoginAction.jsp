<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="utils.Utils" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page import="java.net.URLEncoder" %>

<%
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");

    String message = "";
    if (Utils.isNullOrEmpty(id) || Utils.isNullOrEmpty(pw)) {
        message = "아이디와 비밀번호를 정확히 입력해 주세요";
        session.setAttribute("message", message);
        response.sendRedirect("../index.jsp");
    } else {
        request.setCharacterEncoding("utf-8");
        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");

    }

%>

<script>
</script>