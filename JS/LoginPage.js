var loginBtn = document.getElementById("login_btn");
var inputId = document.getElementById("input_id");
var inputPw = document.getElementById("input_pw");
var loginForm = document.getElementById("login_form");
loginBtn.addEventListener("click", (event) => {
  event.preventDefault();
  console.log(inputId.value == null);
  if (!inputId.value) {
    alert("아이디를 입력해 주세요");
    inputId.focus();
  } else if (!inputPw.value) {
    alert("비밀번호를 입력해 주세요");
    inputPw.focus();
  } else {
    location.href =
      "../ACTION/LoginActon.jsp?id=" + inputId.value + "&pw=" + inputPw.value;
  }
});
