<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
  String message = (String) session.getAttribute("message");
  if (message != null && !message.trim().isEmpty()) {
      out.println("<script>alert('" + message + "');</script>");
      session.removeAttribute("message");
  }

  String userIdx = (String) session.getAttribute("idx");
  if (userIdx != null) {
    response.sendRedirect("../PAGE/SchedulePage.jsp");
  }

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
  <link rel="styleSheet" href="../CSS/SignUpPage.css"/>
</head>
<body>
  <section class="bold_text">
    <h1 class="title">회원가입</h1>
    <form id="info_form" action="../ACTION/SignUpAction.jsp" method="post">
      <label for="input_id">
        <p>아이디</p>
        <input id="input_id" name="id" class="input_config" placeholder="아이디 (8~20자, 영문+숫자 조합)"></input>
      </label>
      <label for="input_pw">
        <p>비밀번호</p>
        <input id="input_pw" name="password" class="input_config" placeholder="비밀번호 (8~20자 영문+숫자+특수기호)" type="password"></input>
      </label>
      <label for="check_pw">
        <p>비밀번호 재입력</p>
        <input id="check_pw" class="input_config" placeholder="비밀번호 재입력" type="password"></input>
      </label>
      <label for="input_name">
        <p>이름 입력</p>
        <input id="input_name" name="name" class="input_config" placeholder="이름 입력(2~6자 한글 조합)"></input>
      </label>
      <label for="input_contact">
        <p>연락처 입력</p>
        <input id="input_contact" name="contact" class="input_config" placeholder="연락처 입력 (010-0000-0000)" maxlength="13"></input>
      </label>
      <label class="group_box">
        <p>부서 선택</p>
        <div>
          <input class="group_btn" value="경영팀" id="management" type="radio" name="group"><label for="management">경영팀</label>
          <input class="group_btn" value="디자인팀" id="design" type="radio" name="group"><label for="design">디자인팀</label>
        </div>
      </label>
      <button class="action_btn_config" id="sign_up_btn">회원가입</button>
    </form>
  </section>
  <div id="padding"></div>
  <script src="../JS/Global/regex.js"></script>
  <script src="../JS/SignUpPage.js"></script>
</body>