<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="utils.Utils" %>
<%@ page import="utils.Regex" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>

<%
    String logInIdx = (String) session.getAttribute("idx");
    boolean isLogined = false;
    if (logInIdx == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    request.setCharacterEncoding("utf-8");
    String name = request.getParameter("name");
    String contact = request.getParameter("contact");
    String department = request.getParameter("group");
    String idx = (String) session.getAttribute("idx");

    if (Utils.isNullOrEmpty(name)) {
        out.println("<script>");
        out.println("alert('이름을 다시 입력해 주세요');");
        out.println("history.back();");
        out.println("</script>");
        return;
    } else if (Utils.isNullOrEmpty(contact)) {
        out.println("<script>");
        out.println("alert('연락처를 다시 입력해 주세요');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }

    String errorMessage = "";
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
        String updateAccountInfoSql = "UPDATE account SET name=?, contact=?, department=? WHERE idx=?";
        PreparedStatement updateAccountInfoQuery = connect.prepareStatement(updateAccountInfoSql);
        updateAccountInfoQuery.setString(1, name);
        updateAccountInfoQuery.setString(2, contact);
        updateAccountInfoQuery.setString(3, department);
        updateAccountInfoQuery.setInt(4, Integer.parseInt(idx));
        updateAccountInfoQuery.executeUpdate();
        out.println("<script>alert('수정이 완료되었습니다')</script>");
        out.println("<script>location.href='../PAGE/UpdateAccountPage.jsp?'</script>");
    } catch (SQLException e) {
        errorMessage = e.getMessage();
        String regex = "for key '(.*?)'";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(errorMessage);
        if (matcher.find()) {
            errorMessage = "사용할 수 없는 " + matcher.group(1) + "입니다";
            out.println("<script>history.back()</script>");
            out.println("<script>alert('" + errorMessage + "');</script>");
            return;
        }    
    }
%>
