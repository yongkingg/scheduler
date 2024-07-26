var findIdBtn = document.getElementById("find_id_btn");
findIdBtn.addEventListener("click", () => {
  var inputContact = document.getElementById("input_contact");
  if (isValidate(contactRegex, inputContact)) {
    location.href = "../ACTION/FindIdAction.jsp?contact=" + inputContact.value;
  } else {
    alert("연락처를 올바르게 입력해 주세요");
  }
});
