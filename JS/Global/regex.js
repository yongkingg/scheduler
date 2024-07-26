const idRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$/;
const pwRegex =
  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$/;
const contactRegex = /^(0[2-9]\d{1,2}|010)-(\d{3,4})-(\d{4})$/;
const nameRegex = /^[가-힣]{2,6}$/;

const validationRules = [
  {
    regex: idRegex,
    message: "아이디를 올바르게 기입해 주세요",
  },
  {
    regex: pwRegex,
    message: "비밀번호를 올바르게 기입해 주세요",
  },
  {
    regex: nameRegex,
    message: "이름을 올바르게 기입해 주세요",
  },
  {
    regex: contactRegex,
    message: "연락처를 올바르게 기입해 주세요",
  },
];

function isValidate(regex, element) {
  return regex.test(element.value);
}

function isTeamChecked() {
  var radioButtons = document.querySelectorAll('input[name="group"]');
  for (var radio of radioButtons) {
    if (radio.checked) {
      return radio.id;
    }
  }
  return false;
}
