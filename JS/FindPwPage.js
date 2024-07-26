var findPwBtn = document.getElementById("find_pw_btn");
var inputId = document.getElementById("input_id");
var inputContact = document.getElementById("input_contact");
findPwBtn.addEventListener("click", () => {
  if (!isValidate(idRegex, inputId)) {
    alert("아이디를 올바르게 입력해 주세요");
  } else if (!isValidate(contactRegex, inputContact)) {
    alert("연락처를 올바르게 입력해 주세요");
  } else {
    location.href =
      "../ACTION/FindPwAction.jsp?id=" +
      inputId.value +
      "&contact=" +
      inputContact.value;
  }
});
