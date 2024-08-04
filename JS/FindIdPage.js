var findIdBtn = document.getElementById("find_id_btn");
var findIdForm = document.getElementById("find_id_form");
findIdBtn.addEventListener("click", (event) => {
  var inputContact = document.getElementById("input_contact");
  if (!validationRules[3].regex.test(inputContact.value)) {
    alert(validationRules[3].message);
    event.preventDefault();
  } else {
    findIdForm.submit();
  }
});

var inputContact = document.getElementById("input_contact");
inputContact.addEventListener("input", () => {
  inputContact.value = inputContact.value
    .replace(/[^0-9]/g, "")
    .replace(/^(\d{0,3})(\d{0,4})(\d{0,6})$/g, "$1-$2-$3")
    .replace(/(\-{1,2})$/g, "");
});
