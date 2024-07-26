import { nameRegex, contactRegex } from "../JS/Global/regex.js";

var inputContact = document.getElementById("input_contact");
var updateBtn = document.getElementById("update_btn");
updateBtn.addEventListener("click", () => {
  console.log(checkValidId());
  // if (checkValidId()) {
  //   location.href =
  //     "../PAGE/SchedulePage.jsp?alert=회원정보 변경이 완료되었습니다.";
  // }
});

function checkValidId() {
  var inputId = document.getElementById("input_name");
  return nameRegex.test(inputId);
}
function checkValidContact() {
  var inputContact = document.getElementById("input_contact");
  return contactRegex.test(inputContact);
}
function isTeamChecked() {}
