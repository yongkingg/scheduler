<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Date" %>
<%@ page import="utils.Utils" %>


<%
  request.setCharacterEncoding("utf-8");

  //  페이지 접근 권한으로, url로 idx를 조작할 수 있는 문제가 발생한다.
  Class.forName("org.mariadb.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
  String key = request.getParameter("key");
  String day = Utils.filterNumbers(request.getParameter("day"));
  String month = Utils.filterNumbers(request.getParameter("month"));
  String year = Utils.filterNumbers(request.getParameter("year"));
  String userIdx = request.getParameter("idx");
  // =================================================== 현재 시간 설정 =====================================================
  String currentTime = Utils.getCurrentTime();
  // =======================================================================================================================

  // =================================================== 페이지 접근 권한 설정 ===============================================
  String logInIdx = (String) session.getAttribute("idx");
  boolean isLogined = false;
  if (logInIdx == null) {
    response.sendRedirect("../index.jsp");
  } else {
    isLogined = true;
  }
  // =======================================================================================================================

  // ================================================== 이름 가져오기 =======================================================
  String name = "";
  String getNameSql = "SELECT name FROM account WHERE idx=?";
  PreparedStatement getNameQuery = connect.prepareStatement(getNameSql);
  getNameQuery.setString(1,userIdx);
  ResultSet getNameResult = getNameQuery.executeQuery();
  if (getNameResult.next()) {
    name = getNameResult.getString("name");
  }
  // =======================================================================================================================

  // ================================================== 리스트 내용 가져오기 =======================================================
  String getScheduleSql = "SELECT idx, DATE_FORMAT(start_time, '%H:%i') AS start_time, DATE_FORMAT(end_time, '%H:%i') AS end_time, schedule.content FROM schedule WHERE YEAR(date) = ? AND MONTH(date) = ? AND DAY(date) = ? AND writer = ? ORDER BY start_time ASC;";
  PreparedStatement getScheduleQuery = connect.prepareStatement(getScheduleSql);
  getScheduleQuery.setInt(1, Integer.parseInt(year));
  getScheduleQuery.setInt(2, Integer.parseInt(month));
  getScheduleQuery.setInt(3, Integer.parseInt(day));
  getScheduleQuery.setString(4, userIdx);
  ResultSet getScheduleResult = getScheduleQuery.executeQuery();
%>


<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Schedule</title>
  <link rel="styleSheet" href="../CSS/Global/theme.css"/>
  <link rel="styleSheet" href="../CSS/Global/setting.css"/>
  <link rel="styleSheet" href="../CSS/SelectSchedulePage.css"/>
</head>
<body>
  <section id="page_info_box" class="bold_text">
      <h1 id="date"><%= year %>년 <%= month %>월 <%= day%>일</h1>
      <h1 id="member"><%=name%>님의 일정</h1>
  </section>
  <%
    if (key.equals("0")) {
  %>
    <section id="input_schedule_box">
      <input id="input_content" class="bold_text" type="text" placeholder="일정을 추가해 보세요" minlength="4", maxlength="50"/>
      <div id="input_date_box" >
        <input id="input_start" class="bold_text" placeholder="시작 시간" maxlength="5"/>
        <input id="input_end" class="bold_text" placeholder="종료 시간" maxlength="5"/>
        <button id="input_schedule_btn" class="bold_text">추가하기</button>
      </div>
    </section>
  <%
    }
  %>

  <main id="schedule_show_box">
  <%
    while(getScheduleResult.next()) {
  %>
    <div class="schedule bold_text"  data-schedule-idx='<%=getScheduleResult.getString("idx")%>'>
      <div class="schedule_item_box">
        <p><%=year%>/<%=month%>/<%=day%>/</p><p class="edit_start_time_input"><%=getScheduleResult.getString("start_time")%></p>
        <p> ~ </p>
        <p><%=year%>/<%=month%>/<%=day%>/</p><p class="edit_end_time_input"><%=getScheduleResult.getString("end_time")%></p>
        <%
          if (key.equals("0")) {
        %>
          <button class="edit_schedule bold_text">수정</button>
          <button class="delete_schedule bold_text">삭제</button>
        <%
          }
        %>
      </div>
      <p class="schedule_content"><%=getScheduleResult.getString("content")%></p>
    </div>
  <%
    }
  %>
    <div id="padding"></div>
  </main>
  <script>
    let idx = null
    let currentTime = "<%=currentTime%>"
    if (<%=isLogined%>) {idx = "<%=logInIdx%>"}
    if ("<%=userIdx%>" != "null" && idx != "<%=userIdx%>") {
        idx = "<%=userIdx%>"
        key = 1
      } 
  </script>
  <script src="../JS/Global/regex.js"></script>
  <script src="../JS/SelectSchedulePage.js"></script>
  <script>
  </script>
</body>