var inputId = document.getElementById("input_id");
var inputPw = document.getElementById("input_pw");
var inputCheckPw = document.getElementById("check_pw");
var inputName = document.getElementById("input_name");
var inputContact = document.getElementById("input_contact");
var infoForm = document.getElementById("info_form");

inputContact.addEventListener("input", () => {
  inputContact.value = inputContact.value
    .replace(/[^0-9]/g, "")
    .replace(/^(\d{0,3})(\d{0,4})(\d{0,6})$/g, "$1-$2-$3")
    .replace(/(\-{1,2})$/g, "");
});

var signUpBtn = document.getElementById("sign_up_btn");
signUpBtn.addEventListener("click", (event) => {
  event.preventDefault();
  // 여기는 그냥 if문 6개 쓰는게 낫다
  const inputs = [inputId, inputPw, inputName, inputContact];
  for (var index = 0; index < inputs.length; index++) {
    if (!validationRules[index].regex.test(inputs[index].value)) {
      alert(validationRules[index].message);
      return;
    } else if (inputPw.value !== inputCheckPw.value) {
      alert("비밀번호가 일치하지 않습니다.");
      return;
    }
  }
  if (!isTeamChecked()) {
    alert("부서를 선택해 주세요");
  } else {
    infoForm.submit();
  }
});
