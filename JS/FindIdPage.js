import { contactRegex } from "../JS/Global/regex.js";

var findIdBtn = document.getElementById("find_id_btn");
findIdBtn.addEventListener("click", () => {
  console.log(isValidContact());
});

function isValidContact() {
  var inputContact = document.getElementById("input_contact");
  return contactRegex.test(inputContact.value);
}
