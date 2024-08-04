var updateForm = document.getElementById("update_form");
var updateBtn = document.getElementById("update_btn");

var inputName = document.getElementById("input_name");
var inputContact = document.getElementById("input_contact");
inputContact.addEventListener("input", () => {
  inputContact.value = inputContact.value
    .replace(/[^0-9]/g, "")
    .replace(/^(\d{0,3})(\d{0,4})(\d{0,6})$/g, "$1-$2-$3")
    .replace(/(\-{1,2})$/g, "");
});

updateBtn.addEventListener("click", (event) => {
  event.preventDefault();
  // 이름 유효성 검사
  if (!validationRules[2].regex.test(inputName.value)) {
    alert(validationRules[2].message);
    return;
    // 연락처 유효성 검사
  } else if (!validationRules[3].regex.test(inputContact.value)) {
    alert(validationRules[3].message);
    return;
  } else {
    updateForm.submit();
  }
});

// ==============================================뒤로가기 버튼 이벤트=============================================== //
window.history.pushState({ page: 2 }, "SelectSchedulePage", location.href);
console.log(window.history.state);
window.addEventListener("popstate", () => {
  window.location.href = "../PAGE/SchedulePage.jsp?idx=" + idx;
});
// ================================================================================================================ //
