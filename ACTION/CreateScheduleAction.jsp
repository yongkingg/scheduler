<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="utils.Utils" %>

<%
    request.setCharacterEncoding("utf-8");
    String content = request.getParameter("content");
    String startTime = request.getParameter("start_time");
    String endTime = request.getParameter("end_time");
    String writerIdx = request.getParameter("writer");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String date = year + "-" + month + "-" + day;
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
    // 정규표현식으로 하셈, jqeury로 받아온 값도 예외처리 하셈
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
        String createScheduleSql = "INSERT INTO schedule (writer, date, start_time, end_time, content) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement createScheduleQuery = connect.prepareStatement(createScheduleSql);
        createScheduleQuery.setString(1, writerIdx);
        createScheduleQuery.setString(2, date);
        createScheduleQuery.setString(3, startTime);
        createScheduleQuery.setString(4, endTime);
        createScheduleQuery.setString(5, content);
        createScheduleQuery.executeUpdate();
    } catch (Exception e) {
        out.println("<script>alert('일정을 추가할 수 없습니다. 잠시 뒤에 시도해주세요')</scirpt>");
    }
%>

<script>
    location.href="../PAGE/SelectSchedulePage.jsp?key=0&day=" + "<%=day%>" + "&year=" + "<%=year%>" + "&month=" + "<%=month%>" +"&idx=" + "<%=writerIdx%>"
    alert("일정 입력이 완료되었습니다")
</script>