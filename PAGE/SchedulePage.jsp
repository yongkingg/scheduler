<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="utils.Utils" %>
<%@ page import="java.util.LinkedHashMap" %>

<%
  request.setCharacterEncoding("utf-8");
  // ==================================== 날짜구하기 ==================================== //
  Calendar calendar = new GregorianCalendar();

  // year month는 같이 받는게 맞았다.
  String month = request.getParameter("month");
  if (Utils.isNullOrEmpty(month)) {
    month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
  } else {
    month = Utils.filterNumbers(month);
  }

  String year = request.getParameter("year");
  if (Utils.isNullOrEmpty(year)) {
    year = String.valueOf(calendar.get(Calendar.YEAR));
  } else {
    year = Utils.filterNumbers(year);
  }

  calendar = new GregorianCalendar(Integer.parseInt(year), Integer.parseInt(month) - 1, 1);
  int days = calendar.getActualMaximum(GregorianCalendar.DAY_OF_MONTH);
  int firstDay = calendar.get(Calendar.DAY_OF_WEEK);
  String[] daysOfWeek = {"", "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};
  String firstDayOfWeekStr = daysOfWeek[firstDay];
  // ==================================================================================== //

  // ====================================로그인 계정, 직급 받기, 페이지 접근 권한 설정============================ //
  boolean role = false; 
  // string으로 if문을 쓰는걸 지양해야한다. 왜냐면 오타 검증 불가능 이거는 변수로 쓰는게 맞았다.
  String clickedMemberIdx = request.getParameter("idx"); // 팀장의 경우, 팀원의 일정 보기 클릭했을때, 해당 계정의 idx를 저장하기 위해 사용
  // key 겹치지 않게 사용 (위 아래)
  String logInIdx = (String) session.getAttribute("idx");
  boolean isLogined = false;
  if (logInIdx == null) {
    // 세션 미존재 시 페이지 접근 제한
    response.sendRedirect("../index.jsp");
    return;
  } else {
    isLogined = true;
    role = "1".equals((String) session.getAttribute("role")) ? true : "2".equals((String) session.getAttribute("role")) ? false : false;
  }
  // ========================================================================================================================= //

  // =====================================================계정 정보 받기 정보 받기============================================== //
  Class.forName("org.mariadb.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
  String getUserInfoSql = "SELECT a.idx AS account_idx, a.id, a.name, a.contact, r.role_name AS role, d.group_name AS department FROM account a JOIN role r ON a.role = r.idx JOIN department d ON a.department = d.idx WHERE a.idx = ?;";
  PreparedStatement getUserInfoQuery = connect.prepareStatement(getUserInfoSql);
  getUserInfoQuery.setString(1, logInIdx);
  ResultSet getInfoResult = getUserInfoQuery.executeQuery();
  String id = "";
  String name = "";
  String contact = "";
  String department = "";
  if (getInfoResult.next()) {
    id = getInfoResult.getString("id");
    name = getInfoResult.getString("name");
    contact = getInfoResult.getString("contact");
    department = getInfoResult.getString("department");
  }
  // =================================================팀원 가져오기(팀장의 경우)==================================================== //
  ResultSet getMemberResult = null;
  if (role) {
    String getMemberSql = "SELECT idx, name FROM account WHERE department=(SELECT idx FROM department WHERE group_name=?) AND role=2";
    PreparedStatement getMemberQuery = connect.prepareStatement(getMemberSql);
    getMemberQuery.setString(1, department);
    getMemberResult = getMemberQuery.executeQuery();
  }
  // =====================================================일정 가져오기========================================================== //
  // 팀장인 경우에만 url로 index 접근 가능하게 .. (권한 추가해야함)
  LinkedHashMap<Integer, Integer> scheduleList = new LinkedHashMap<>();
  String getScheduleSql = "SELECT DAY(date) AS day FROM schedule WHERE MONTH(date) = ? AND YEAR(date) = ? AND writer=? ORDER BY date ASC;";
  PreparedStatement getScheduleQuery = connect.prepareStatement(getScheduleSql);
  getScheduleQuery.setString(1, month);
  getScheduleQuery.setString(2, year);
  if (clickedMemberIdx == null) {
    getScheduleQuery.setString(3, logInIdx);
  } else if (clickedMemberIdx != logInIdx) {
    getScheduleQuery.setString(3, clickedMemberIdx);
  }
  // =========================== 피드백 =========================== // 
  // 여기에 권한을 체크해야함 권한을 체크한 뒤 모든게 다 통과되면 그때 sql, query를 만들고 데이터를 가져오고, 권한이 없다면 실행하지 않게 수정해야함. 
  ResultSet getScheduleResult = getScheduleQuery.executeQuery();
  while (getScheduleResult.next()) {
    Integer date = getScheduleResult.getInt("day");
    if (scheduleList.get(date) == null) {
      scheduleList.put(date, 1);
    } else {
      Integer currentCount = scheduleList.get(date);
      scheduleList.put((date), currentCount + 1);
    }
  }
  // =========================================================================================================================== //
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
      <h1><%=id%></h1>
      <h1><%=department%> <%=name%></h1>
      <h1><%=contact%></h1>
    </div>
    <div class="member_box hide">
      <%
        if (role) {
          while (getMemberResult.next()){
            String memberIdx = getMemberResult.getString("idx");
      %>
        <a class="member" data-user-idx=<%=memberIdx%> href="../PAGE/SchedulePage.jsp?idx=<%=memberIdx%>&month=<%=month%>&year=<%=year%>"><%=getMemberResult.getString("name")%></a>
      <%
          }
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
            Integer scheduleCount = scheduleList.get(index+1);
        %>
          <div class="grid_item" data-day=<%=index + 1%> style="grid-column: <%= column %>; grid-row: <%= row %>;">
            <p class="date <%=isSpecialColumn%>"><%= index + 1 %></p>
            <%
              if (scheduleCount != null) {
            %>
                <p class="schedule_count"><%=scheduleCount%></p>
            <%
              }
            %>
          </div>
        <%
          }
        %>
      </div>
    </section>
  </main>
  <script>
    let idx = null
    let key = null
    let clickedMemberIdx = "<%=clickedMemberIdx%>"
    if (<%=isLogined%>) {
      idx = "<%=logInIdx%>"
      key = 0
    }
    // 팀장이 팀원 눌렀을때
    if (clickedMemberIdx != "null" && idx != clickedMemberIdx) {
        idx = "<%=clickedMemberIdx%>"
        key = 1
      } 
  </script>
  <script src="../JS/SchedulePage.js"></script>
</body>