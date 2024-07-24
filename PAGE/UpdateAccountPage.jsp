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
  <link rel="styleSheet" href="../CSS/UpdateAccountPage.css"/>

</head>
<body>
  <section class="bold_text">
    <h1 class="title">계정 정보 수정</h1>
    <form action="loginAction.jsp" method="post" autocomplete="on">
      <label for="input_id">
        <p>이름 입력</p>
        <input id="input_id" class="input_config" placeholder="최민석"></input>
      </label>
      <label for="input_contact">
        <p>연락처 입력</p>
        <input id="input_contact" class="input_config" placeholder="연락처 입력 (010-0000-0000)"></input>
      </label>
      <label class="group_box">
        <p>부서 선택</p>
        <div>
          <input class="group_btn" id="management" type="radio" name="group"><label for="management">경영팀</label>
          <input class="group_btn" id="design" type="radio" name="group"><label for="design">디자인팀</label>
        </div>
      </label>
    </form>
    <button class="action_btn_config" id="update_btn">변경하기</button>
  </section>
  <script src="../JS/UpdateAccountPage.js"></script>
</body>