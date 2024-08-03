<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="utils.Utils" %>


<%
    request.setCharacterEncoding("utf-8");
    String scheduleIdx = request.getParameter("schedule_idx");
    String content = request.getParameter("content");
    String startTime = request.getParameter("start_time");
    String endTime = request.getParameter("end_time");
    String writerIdx = request.getParameter("writer");
    if (Utils.isNullOrEmpty(content)) {
        out.println("<script>");
        out.println("alert('일정 내용을 다시 입력해 주세요');");
        out.println("history.back();");
        out.println("</script>");
        return;
    } else if (Utils.isNullOrEmpty(startTime)) {
        out.println("<script>");
        out.println("alert('시작시간을 다시 입력해 주세요');");
        out.println("history.back();");
        out.println("</script>");
        return;
    } else if (Utils.isNullOrEmpty(endTime)) {
        out.println("<script>");
        out.println("alert('종료시간을 다시 입력해 주세요');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
    String updateScheduleSql = "UPDATE schedule SET start_time=?, end_time=?, content=? WHERE idx=?";
    PreparedStatement updateScheduleQuery = connect.prepareStatement(updateScheduleSql);
    updateScheduleQuery.setString(1, startTime);
    updateScheduleQuery.setString(2, endTime);
    updateScheduleQuery.setString(3, content);
    updateScheduleQuery.setString(4, scheduleIdx);
    updateScheduleQuery.executeUpdate();
%>

<script>
    console.log("<%=content%>")
    console.log("<%=startTime%>")
    console.log("<%=endTime%>")
    console.log("<%=scheduleIdx%>")
    console.log("<%=writerIdx%>")
</script>