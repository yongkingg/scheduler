<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="utils.Utils" %>

<%
    request.setCharacterEncoding("utf-8");
    String contactValue = request.getParameter("contact");
    if (Utils.isNullOrEmpty(contactValue)) {
        out.println("<script>");
        out.println("alert('연락처를 다시 입력해 주세요');");
        out.println("history.back();");
        out.println("</script>");
        return;
    } 

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
    String findIdSql = "SELECT id FROM account WHERE contact=?";
    PreparedStatement findIdQuery = connect.prepareStatement(findIdSql);
    findIdQuery.setString(1, contactValue);
    ResultSet idResult = findIdQuery.executeQuery();
    if (idResult.next()) {
        String id = idResult.getString("id");
        session.setAttribute("message", "당신의 아이디는 : " + id);
        response.sendRedirect("../index.jsp");
        return;
    } else {
        out.println("<script>");
        out.println("alert('존재하지 않는 계정입니다');");
        out.println("history.back();");
        out.println("</script>");
    }
%>
