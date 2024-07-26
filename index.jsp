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
  <title>Login</title>
  <link rel="styleSheet" href="CSS/Global/theme.css"/>
  <link rel="styleSheet" href="CSS/Global/setting.css"/>
  <link rel="styleSheet" href="CSS/LoginPage.css"/>
</head>

<body>
  <section class="bold_text">
    <h1 class="title">SCHEDULER</h1>
    <form action="loginAction.jsp" method="post" autocomplete="on">
      <label for="input_id">
        <p>아이디</p>
        <input id="input_id" class="input_config" placeholder="아이디"></input>
      </label>
      <label for="input_pw">
        <p>비밀번호</p>
        <input id="input_pw" class="input_config" placeholder="비밀번호" type="password"></input>
      </label>
    </form>
    <button id="login_btn" class="action_btn_config">로그인</button>
    <div id="button_container">
      <a href="/PAGE/FindIdPage.jsp">아이디 찾기</a>
      <a href="/PAGE/FindPwPage.jsp">비밀번호 찾기</a>
      <a href="/PAGE/SignUpPage.jsp">회원가입</a>
    </div>
  </section>
  <script src="JS/LoginPage.js"></script>
</body>