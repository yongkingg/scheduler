<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
  request.setCharacterEncoding("utf-8");
  String logInIdx = (String) session.getAttribute("idx");
  String role = "";
  boolean isLogined = false;
  if (logInIdx == null) {
    response.sendRedirect("../index.jsp");
  } else {
    isLogined = true;
    role = "1".equals((String) session.getAttribute("role")) ? "팀장" : "2".equals((String) session.getAttribute("role")) ? "팀원" : "";
  }

  ResultSet getAccountInfoResult = null;
  try {
    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "stageus", "1234");
    String getAccountInfoSql = "SELECT name, contact, department FROM account WHERE idx=?";
    PreparedStatement getAccountInfoQuery = connect.prepareStatement(getAccountInfoSql);
    getAccountInfoQuery.setString(1, logInIdx);
    getAccountInfoResult = getAccountInfoQuery.executeQuery();
  } catch (Exception e) {
    out.println("<script>alert('지금은 정보를 수정할 수 없습니다. 잠시 후에 다시 시도해주세요');</script>");
  }
  
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
    <%
      if (getAccountInfoResult.next()) {
    %>
    <form id="update_form" action="../ACTION/UpdateAccountAction.jsp" method="post">
      <label for="input_name">
        <p>이름 입력</p>
        <input id="input_name" name="name" class="input_config" placeholder="<%=getAccountInfoResult.getString("name")%>"></input>
      </label>
      <label for="input_contact">
        <p>연락처 입력</p>
        <input id="input_contact" name="contact" class="input_config" maxlength="13" placeholder="<%=getAccountInfoResult.getString("contact")%>"></input>
      </label>
      <label class="group_box">
        <p>부서 선택</p>
        <div>
          <input class="group_btn" id="management" type="radio" name="group" value="1"
          <%
            if (getAccountInfoResult.getString("department").equals("1")) {
          %>
            checked
          <%
            }
          %>
          /><label for="management">경영팀</label>
          <input class="group_btn" id="design" type="radio" name="group" value="2"
          <%
            if (getAccountInfoResult.getString("department").equals("2")) {
          %>
            checked
          <%
            }
          %>
          /><label for="design">디자인팀</label>
        </div>
      </label>
      <button class="action_btn_config" id="update_btn">변경하기</button>
    </form>
    <%
      }
    %>  
  </section>
  <script>
    let idx = null
    if (<%=isLogined%>) {
      idx = "<%=logInIdx%>"
    }
  </script>
  <script src="../JS/Global/regex.js"></script>
  <script type="module" src="../JS/UpdateAccountPage.js"></script>
</body>