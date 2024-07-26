var findIdBtn = document.getElementById("find_id_btn");
findIdBtn.addEventListener("click", (event) => {
  var inputContact = document.getElementById("input_contact");
  if (!isValidate(validationRules[3].regex, inputContact)) {
    alert(validationRules[3].message);
    event.preventDefault();
  }
});

var inputContact = document.getElementById("input_contact");
inputContact.addEventListener("input", () => {
  inputContact.value = inputContact.value
    .replace(/[^0-9]/g, "")
    .replace(/^(\d{0,3})(\d{0,4})(\d{0,6})$/g, "$1-$2-$3")
    .replace(/(\-{1,2})$/g, "");
});
