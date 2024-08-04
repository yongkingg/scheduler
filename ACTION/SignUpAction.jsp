<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="utils.Utils" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>

<%
    request.setCharacterEncoding("utf-8");
    // ==============================================입력 값 검증=============================================
    String idValue = request.getParameter("id");
    String pwValue = request.getParameter("pw");
    String nameValue = request.getParameter("name");
    String contactValue = request.getParameter("contact");
    String groupValue = request.getParameter("group");
    LinkedHashMap<String, String> values = new LinkedHashMap<>();
    values.put("아이디", idValue);
    values.put("비밀번호", pwValue);
    values.put("이름", nameValue);
    values.put("연락처", contactValue);
    values.put("부서", groupValue);
    for (String key : values.keySet()) {
        String getValue = values.get(key);
        if(Utils.isNullOrEmpty(getValue)) {
            session.setAttribute("message", key + "를 다시 입력해 주세요");
            response.sendRedirect("../PAGE/SignUpPage.jsp");
            return;
        }
    }
    // ======================================================================================================

    // ============================================== db 값 입력=============================================
    String errorMessage = "";
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
        String signUpSql = "INSERT INTO account (id, pw, name, contact, department) VALUES (?,?,?,?, (SELECT idx FROM department WHERE group_name = ?))";
        PreparedStatement signUpQuery = connect.prepareStatement(signUpSql);
        signUpQuery.setString(1, idValue);
        signUpQuery.setString(2, pwValue);
        signUpQuery.setString(3, nameValue);
        signUpQuery.setString(4, contactValue);
        signUpQuery.setString(5, groupValue);
        signUpQuery.executeUpdate();
        session.setAttribute("message", "회원가입이 완료되었습니다");
        response.sendRedirect("../index.jsp");
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
    // ======================================================================================================
%>