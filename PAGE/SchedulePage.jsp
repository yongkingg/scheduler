<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
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
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>
      <div class="member">김용준</div>

    </div>
    <div class="account_btn_box hide">
      <button>내 정보 수정</button>
      <button>로그아웃</button>
    </div>
  </aside>

  <main>
    <section id="date_box" class="bold_text">
      <button id="left_btn" class="svg_background"></button>
      <h1>2024년 7월</h1>
      <button id="right_btn" class="svg_background"></button>
    </section>

    <section id="calender_box" class="bold_text">
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
      <div class="grid_item"></div>
    </section>
  </main>



  <script src="../JS/SchedulePage.js"></script>
</body>