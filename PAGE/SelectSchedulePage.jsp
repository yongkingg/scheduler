<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="utils.Utils" %>

<%
  request.setCharacterEncoding("utf-8");

  Calendar calendar = new GregorianCalendar();
  String key = request.getParameter("key");

  String day = Utils.filterNumbers(request.getParameter("day"));
  String month = Utils.filterNumbers(request.getParameter("month"));
  String year = Utils.filterNumbers(request.getParameter("year"));
  String date = year + "-" + month;
  String userIdx = request.getParameter("idx");
  if (userIdx == null) {
    userIdx = (String) session.getAttribute("idx");
  } 
  boolean isLogined = false;
  if (userIdx == null) {
    response.sendRedirect("../index.jsp");
  } else {
    isLogined = true;
  }

  // ================================================== 리스트 내용 가져오기 =======================================================
  Class.forName("org.mariadb.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
  String getScheduleSql = "SELECT account.name, schedule.idx, schedule.start_time, schedule.end_time, schedule.content FROM schedule INNER JOIN account ON account.idx = schedule.writer WHERE YEAR(schedule.date) = ? AND MONTH(schedule.date) = ? AND schedule.writer = ? ORDER BY schedule.start_time ASC;";
  PreparedStatement getScheduleQuery = connect.prepareStatement(getScheduleSql);
  getScheduleQuery.setInt(1, Integer.parseInt(year));
  getScheduleQuery.setInt(2, Integer.parseInt(month));
  getScheduleQuery.setString(3, userIdx);
  ResultSet getScheduleResult = getScheduleQuery.executeQuery();
  String name = "";
  while(getScheduleResult.next()) {
    out.println("<script>console.log('123');</script>");
    Integer scheduleIdx = getScheduleResult.getInt("idx");
    name = getScheduleResult.getString("name");
  }
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
      <input id="input_content" class="bold_text" type="text" placeholder="일정을 추가해 보세요"/>
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
    for (int index = 0; index < 5; index++) {
  %>
    <div class="schedule bold_text" data-schedule-idx="<%=index%>">
      <div class="schedule_item_box">
        <p>2024/08/31/</p><p class="edit_start_time_input">12:30</p>
        <p> ~ </p>
        <p>2024/08/31/</p><p class="edit_end_time_input">12:30</p>
        <%
          if (key.equals("0")) {
        %>
          <button class="edit_schedule bold_text">수정</button>
          <button class="delete_schedule bold_text">삭제</button>
        <%
          }
        %>
      </div>
      <p class="schedule_content">스케줄스케줄스케줄스케줄스스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄케줄</p>
    </div>
  <%
    }
  %>
    <div id="padding"></div>
  </main>
    <script>
    let idx = null
    if (<%=isLogined%>) idx = "<%=userIdx%>"
    console.log("<%=name%>")
  </script>
  <script src="../JS/Global/regex.js"></script>
  <script src="../JS/SelectSchedulePage.js"></script>
  <script>
  </script>
</body>