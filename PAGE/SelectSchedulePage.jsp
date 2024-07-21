<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    String key = request.getParameter("key");
    request.setCharacterEncoding("utf-8");
    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
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
    <h1 id="date">2024년 8월 31일</h1>
    <h1 id="member">김용준님의 일정</h1>
  </section>

  <%
    if (key.equals("0")) {
  %>
    <section id="input_schedule_box">
      <input id="input_content" class="bold_text" type="text" placeholder="일정을 추가해 보세요"/>
      <div id="input_date_box" >
        <input id="input_start" class="bold_text" value="2024년 08월 31일 12시 30분"/>
        <input id="input_end" class="bold_text" value="2024년 08월 31일 15시 30분" />
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
    <div class="schedule bold_text">
      <div id="schedule_item_box">
        <p id="start_date">2024/08/31/12:30</p>
        <p> ~ </p>
        <p id="end_date">2024/08/31/12:30</p>
        <button id="edit_schedule" class="bold_text">수정</button>
        <button id="delete_schedule" class="bold_text">삭제</button>
      </div>
      <p id="schedule_content">스케줄스케줄스케줄스케줄스스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄스케줄케줄</p>
    </div>
  <%
    }
  %>
    <div id="padding"></div>

  </main>
</body>