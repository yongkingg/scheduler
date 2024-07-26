var inputId = document.getElementById("input_id");
var inputPw = document.getElementById("input_pw");
var inputCheckPw = document.getElementById("check_pw");
var inputName = document.getElementById("input_name");
var inputContact = document.getElementById("input_contact");
inputContact.addEventListener("input", () => {
  const inputValue = inputContact.value.replace(/[^0-9]/g, "");
  let formattedValue = "";

  if (inputValue.startsWith("010")) {
    formattedValue += "010";
    if (inputValue.length > 3) {
      formattedValue += "-";
      formattedValue += inputValue.substring(3, 7);
    }
    if (inputValue.length > 7) {
      formattedValue += "-";
      formattedValue += inputValue.substring(7, 11);
    }
  } else {
    formattedValue = inputValue;
  }

  inputContact.value = formattedValue;
});

var signUpBtn = document.getElementById("sign_up_btn");
signUpBtn.addEventListener("click", () => {
  const inputs = [inputId, inputPw, inputName, inputContact];
  for (let i = 0; i < inputs.length; i++) {
    if (!isValidate(validationRules[i].regex, inputs[i])) {
      alert(validationRules[i].message);
      return;
    } else if (inputPw.value !== inputCheckPw.value) {
      alert("비밀번호가 일치하지 않습니다.");
      return;
    }
  }
  if (!isTeamChecked()) {
    alert("부서를 선택해 주세요");
  } else {
    const team = isTeamChecked();
    location.href = `../ACTION/SignUpAction.jsp?id=${inputId.value}&pw=${inputPw.value}&name=${inputName.value}&contact=${inputContact.value}&team=${team}`;
  }
});
