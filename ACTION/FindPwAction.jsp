<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="utils.Utils" %>

<%
    String logInIdx = (String) session.getAttribute("idx");
    boolean isLogined = false;
    if (logInIdx == null) {
        // 세션 미존재 시 페이지 접근 제한
        response.sendRedirect("../index.jsp");
        return;
    }
    
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id");
    String contactValue = request.getParameter("contact");
    if (Utils.isNullOrEmpty(contactValue)) {
        out.println("<script>");
        out.println("alert('연락처를 다시 입력해 주세요');");
        out.println("history.back();");
        out.println("</script>");
        return;
    } else if (Utils.isNullOrEmpty(idValue)) {
        out.println("<script>");
        out.println("alert('아이디를 다시 입력해 주세요');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }
    
    ResultSet pwResult = null;
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
        String findPwSql = "SELECT pw FROM account WHERE id=? AND contact=?";
        PreparedStatement findPwQuery = connect.prepareStatement(findPwSql);
        findPwQuery.setString(1, idValue);
        findPwQuery.setString(2, contactValue);
        pwResult = findPwQuery.executeQuery();
    } catch (Exception e) {
        out.println("<script>alert('비밀번호를 찾을 수 없습니다. 잠시 후에 다시 시도해주세요')</script>")
    } finally {
        if (pwResult.next()) {
        String pw = pwResult.getString("pw");
        session.setAttribute("message", "당신의 비밀번호는 : " + pw);
        response.sendRedirect("../index.jsp");
        return;
    } else {
        out.println("<script>");
        out.println("alert('존재하지 않는 계정입니다');");
        out.println("history.back();");
        out.println("</script>");
    }
    }
%>
