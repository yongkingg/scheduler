import { idRegex, contactRegex } from "../JS/Global/regex.js";

var findPwBtn = document.getElementById("find_pw_btn");
findPwBtn.addEventListener("click", () => {
  console.log(isValidContact());
  console.log(isValidId());
});

function isValidId() {
  var inputId = document.getElementById("input_id");
  return idRegex.test(inputId.value);
}
function isValidContact() {
  var inputContact = document.getElementById("input_contact");
  return contactRegex.test(inputContact.value);
}
