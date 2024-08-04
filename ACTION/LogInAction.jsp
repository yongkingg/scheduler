<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
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

    ResultSet loginResult = null;
    try {
        request.setCharacterEncoding("utf-8");
        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
        String loginSql = "SELECT * FROM account WHERE id=? AND pw=?";
        PreparedStatement loginQuery = connect.prepareStatement(loginSql);
        loginQuery.setString(1, idValue);
        loginQuery.setString(2, pwValue);
        loginResult = loginQuery.executeQuery();
    } catch (Exception e) {
        out.println("<script>alert('로그인할 수 없습니다. 잠시 후에 다시 시도해주세요')</script>");
    } finally {
        if (loginResult.next()) {
        int userIdx = loginResult.getInt("idx");
        int role = loginResult.getInt("role");
        session.setAttribute("idx", String.valueOf(userIdx));
        session.setAttribute("role", String.valueOf(role));
        response.sendRedirect("../PAGE/SchedulePage.jsp");
        return;
        } else {
            message = "존재하지 않는 계정입니다";
            session.setAttribute("message", message);
            response.sendRedirect("../index.jsp");
        }
    }   
%>
