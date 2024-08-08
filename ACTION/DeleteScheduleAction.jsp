<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="utils.Utils" %>

<%
    String logInIdx = (String) session.getAttribute("idx");
    String userIdx = request.getParameter("idx");
    boolean isLogined = false;
    if (logInIdx == null) {
        response.sendRedirect("../index.jsp");
        return;
    } else if (userIdx != logInIdx) {
        out.println("history.back();");
        return;
    }

    request.setCharacterEncoding("utf-8");
    String scheduleIdx = request.getParameter("schedule_idx");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");

    if (Utils.isNullOrEmpty(scheduleIdx)) {
        out.println("<script>");
        out.println("alert('해당 일정을 삭제할 수 없습니다');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }
    
    try {
        Class.forName("org.mariadb.jdbc.Driver");       
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
        String deleteScheduleSql = "DELETE FROM schedule WHERE idx=?";
        // account idx 추가해야함.
        PreparedStatement deleteScheduleQuery = connect.prepareStatement(deleteScheduleSql);
        deleteScheduleQuery.setString(1, scheduleIdx);
        deleteScheduleQuery.executeUpdate();
    } catch(Exception e) {
        out.println("<script>alert('일정을 삭제할 수 없습니다. 잠시 뒤에 시도해주세요')</scirpt>");
    }
    
%>

<script>
    location.href ="../PAGE/SelectSchedulePage.jsp?key=0&idx=<%=userIdx%>+&year=<%=year%>+&month=<%=month%>+&day=<%=day%>"
    alert("일정 삭제가 완료되었습니다")
</script>