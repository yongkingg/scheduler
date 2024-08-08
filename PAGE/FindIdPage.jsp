<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
  String userIdx = (String) session.getAttribute("idx");
  if (userIdx != null) {
    response.sendRedirect("../PAGE/SchedulePage.jsp");
  }
  
  String message = (String) session.getAttribute("message");
  if (message != null && !message.trim().isEmpty()) {
      out.println("<script>alert('" + message + "');</script>");
      session.removeAttribute("message");
      // response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
      // response.setHeader("Pragma", "no-cache");
      // response.setDateHeader("Expires", 0);
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
  <link rel="styleSheet" href="../CSS/FindIdPage.css"/>
</head>
<body>
  <section class="bold_text">
    <h1 class="title">아이디 찾기</h1>
    <form id="find_id_form" action="../ACTION/FindIdAction.jsp" method="post" autocomplete="on">
      <label for="input_contact">
        <p>연락처 입력</p>
        <input id="input_contact" name="contact" class="input_config" placeholder="연락처 입력" maxlength="13"></input>
      </label>
      <button class="action_btn_config" id="find_id_btn">아이디 찾기</button>
    </form>
  </section>
  
  <script src="../JS/Global/regex.js"></script>
  <script src="../JS/FindIdPage.js"></script>

</body>