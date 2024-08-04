const idRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$/;
const pwRegex =
  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$/;
const contactRegex = /^(0[2-9]\d{1,2}|010)-(\d{3,4})-(\d{4})$/;
const nameRegex = /^[가-힣]{2,6}$/;
const scheduleRegex = /^.{4,50}$/;
const timeRegex = /^(?:[01]\d|2[0-3]):[0-5]\d$/;
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
  {
    regex: scheduleRegex,
    message: "일정은 4~50자 사이여야 합니다.",
  },
];

function timeRegexForm(value) {
  return value
    .replace(/[^0-9]/g, "")
    .replace(/^(\d{0,2})(\d{0,2})$/g, "$1:$2")
    .replace(/(\:{1,2})$/g, "");
}

function isValidateContent(content) {
  if (!validationRules[4].regex.test(content)) {
    throw new Error(validationRules[4].message);
  }
}

function isValidateTime(inputTime, key) {
  if (inputTime == "") {
    throw new Error(key + "을 입력해 주세요");
  }
  if (!timeRegex.test(inputTime)) {
    throw new Error("시간은 00:00~23:59까지 입력 가능합니다");
  }
}

function isValidateTimeRelationship(startTime, endTime) {
  if (
    parseInt(startTime.replace(/[^0-9]/g, ""), 10) >
    parseInt(endTime.replace(/[^0-9]/g, ""), 10)
  ) {
    throw new Error("종료시각은 시작시간 이후로 설정해주세요");
  }
}

function isValuesChanged(values) {
  var anyChanged = false;
  for (var item of values) {
    if (item.dataset.originalText != item.value) {
      anyChanged = true;
      break;
    }
  }
  return anyChanged;
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
