var findPwBtn = document.getElementById("find_pw_btn");
var findPwForm = document.getElementById("find_pw_form");
var inputId = document.getElementById("input_id");
var inputContact = document.getElementById("input_contact");
findPwBtn.addEventListener("click", (event) => {
  if (!inputId.value) {
    alert("아이디를 입력해 주세요");
    event.preventDefault();
  } else if (!isValidate(validationRules[3].regex, inputContact)) {
    alert(validationRules[3].message);
    event.preventDefault();
  }
});

inputContact.addEventListener("input", () => {
  inputContact.value = inputContact.value
    .replace(/[^0-9]/g, "")
    .replace(/^(\d{0,3})(\d{0,4})(\d{0,6})$/g, "$1-$2-$3")
    .replace(/(\-{1,2})$/g, "");
});
