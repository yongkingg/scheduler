<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="utils.Utils" %>

<%
    String logInIdx = (String) session.getAttribute("idx");
    String writerIdx = request.getParameter("writer");  
    boolean isLogined = false;
    if (logInIdx == null) {
        response.sendRedirect("../index.jsp");
        return;
    } else if (!logInIdx.equals(writerIdx)) {
        out.println("history.back();");
        return;
    }

    request.setCharacterEncoding("utf-8");
    String scheduleIdx = request.getParameter("schedule_idx");
    String content = request.getParameter("content");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String startTime = request.getParameter("start_time");
    String endTime = request.getParameter("end_time");
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
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
        String updateScheduleSql = "UPDATE schedule SET start_time=?, end_time=?, content=? WHERE idx=? AND writer=?";
        // 여기에 session idx 추가해야함
        PreparedStatement updateScheduleQuery = connect.prepareStatement(updateScheduleSql);
        updateScheduleQuery.setString(1, startTime);
        updateScheduleQuery.setString(2, endTime);
        updateScheduleQuery.setString(3, content);
        updateScheduleQuery.setString(4, scheduleIdx);
        updateScheduleQuery.setString(5, logInIdx);
        updateScheduleQuery.executeUpdate();
        out.println("<script>alert('일정 수정이 완료되었습니다');</script>");
    } catch (Exception e) {
        out.println("<script>alert('일정을 수정할 수 없습니다. 잠시 후에 다시 시도해주세요');</script>");
    } finally {
        out.println("<script>location.href='../PAGE/SelectSchedulePage.jsp?key=0&idx=" + writerIdx + "&year=" + year + "&month=" + month + "&day=" + day + "';</script>");
    }
%>