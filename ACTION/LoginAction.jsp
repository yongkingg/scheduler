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
    String idValue = request.getParameter("id");
    String pwValue = request.getParameter("pw");

    String message = "";
    if (Utils.isNullOrEmpty(idValue) || Utils.isNullOrEmpty(pwValue)) {
        message = "아이디와 비밀번호를 정확히 입력해 주세요";
        session.setAttribute("message", message);
        response.sendRedirect("../index.jsp");
        return;
    }

    request.setCharacterEncoding("utf-8");
    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
    String sql = "SELECT FROM account WHERE id=? AND pw=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);
    ResultSet result = query.executeQuery();
    if (result.next()) {
        int userIdx = result.getInt("idx");
        int role = result.getInt("role");
        session.setAttribute("idx", userIdx);
        session.setAttribute("role", role);
        response.sendRedirect("../PAGE/SchedulePage.jsp");
        return;
    } else {
        message = "존재하지 않는 계정입니다";
        session.setAttribute("message", message);
        response.sendRedirect("../index.jsp");
        return;
    }
%>
