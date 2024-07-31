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
  // ==================================== 날짜구하기 ==================================== //
  Calendar calendar = new GregorianCalendar();
  String month = request.getParameter("month");
  if (month == null || month.trim().isEmpty()) {
    month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
  } else {
    month = Utils.filterNumbers(month);  // Calling static method from Utils class
  }

  String year = request.getParameter("year");
  if (year == null || year.trim().isEmpty()) {
    year = String.valueOf(calendar.get(Calendar.YEAR));
  } else {
    year = Utils.filterNumbers(year);  // Calling static method from Utils class
  }

  calendar = new GregorianCalendar(Integer.parseInt(year), Integer.parseInt(month) - 1, 1);
  int days = calendar.getActualMaximum(GregorianCalendar.DAY_OF_MONTH);
  int firstDay = calendar.get(Calendar.DAY_OF_WEEK);
  String[] daysOfWeek = {"", "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};
  String firstDayOfWeekStr = daysOfWeek[firstDay];
  // ==================================================================================== //

  // ====================================로그인 계정, 직급 받기, 페이지 접근 권한 설정============================ //
  String role = (String) session.getAttribute("role");
  String userIdx = (String) session.getAttribute("idx");
  boolean isLogined = false;
  if (userIdx == null) {
    response.sendRedirect("../index.jsp");
  } else {
    isLogined = true;
  }
  // ==================================================================================== //

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
  <link rel="styleSheet" href="../CSS/SchedulePage.css"/>
</head>
<body>
  <aside id="aside">
    <button id="aside_btn" class="svg_background"></button>
    <div id="home_btn">
      <svg></svg>
      <p>홈</p>
    </div>
    <div id="profile_box" class="bold_text hide">
      <h1>yongkingg</h1>
      <h1>디자인팀 홍길동</h1>
      <h1>010-1111-1111</h1>
    </div>
    <div class="member_box hide">
      <%
        for (int index=0; index < 9; index++) {
      %>
      <a class="member" data-user-idx=<%=index%>>김용준</a>
      <%
        }
      %>
    </div>
    <div class="account_btn_box hide">
      <button id="edit_profile_btn">내 정보 수정</button>
      <button id="log_out_btn">로그아웃</button>
    </div>
  </aside>

  <main>
    <section id="date_box">
      <button id="left_btn" class="svg_background"></button>
      <h1 id="year"><%=year%>년</h1>
      <button id="month"><%=month%>월</button>
      <div id="month_selector" class="hide">
        <button>1</button>
        <button>2</button>
        <button>3</button>
        <button>4</button>
        <button>5</button>
        <button>6</button>
        <button>7</button>
        <button>8</button>
        <button>9</button>
        <button>10</button>
        <button>11</button>
        <button>12</button>
      </div>
      <button id="right_btn" class="svg_background"></button>
    </section>
    <section id="calender_box" class="bold_text">
      <div id="day_box">
        <p style="color : red">일</p>
        <p>월</p>
        <p>화</p>
        <p>수</p>
        <p>목</p>
        <p>금</p>
        <p style="color : blue">토</p>
      </div>
      <div id="calender_grid">
        <%
          int startColumn = firstDay;
          int startRow = 1;
          int totalColumns = 7;
          int totalRows = 6;

          for (int index = 0; index < days; index++) {
            int column = startColumn + (index % totalColumns);
            int row = startRow + (index / totalColumns);

            if (column > totalColumns) {
              column = (column - 1) % totalColumns + 1;
              row += 1;
            }
            if (row > totalRows) {
              row = totalRows;
            }

            String isSpecialColumn = "";
            if (column == 1) {
              isSpecialColumn += "sunday_column";
            }
            if (column == 7) {
              isSpecialColumn += "saturday_column";
            }
        %>
          <div class="grid_item" data-day=<%=index + 1%> style="grid-column: <%= column %>; grid-row: <%= row %>;">
            <a class="date <%=isSpecialColumn%>"><%= index + 1 %></a>
            <a class="schedule_count">23</a>
          </div>
        <%
          }
        %>
      </div>
    </section>
  </main>
  <script>
    let idx = null
    if (<%=isLogined%>) idx = "<%=userIdx%>"
    console.log("<%=userIdx%>")
  </script>
  <script src="../JS/SchedulePage.js"></script>
</body>