import { nameRegex, contactRegex } from "../JS/Global/regex.js";

var inputContact = document.getElementById("input_contact");
var updateBtn = document.getElementById("update_btn");
updateBtn.addEventListener("click", () => {
  console.log(checkValidName());
  console.log(checkValidContact());
  console.log(isTeamChecked());

  if (checkValidName() && checkValidContact() && isTeamChecked()) {
    location.href =
      "../PAGE/SchedulePage.jsp?alert=회원정보 변경이 완료되었습니다.";
  }
});

function checkValidName() {
  var inputName = document.getElementById("input_name");
  return nameRegex.test(inputName.value);
}
function checkValidContact() {
  var inputContact = document.getElementById("input_contact");
  return contactRegex.test(inputContact.value);
}
function isTeamChecked() {
  var radioButtons = document.querySelectorAll('input[name="group"]');
  for (var radio of radioButtons) {
    if (radio.checked) {
      return radio.id;
    }
  }
}
