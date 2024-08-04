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

function isValidate(regex, element) {
  return regex.test(element.value);
}

function timeRegexForm(value) {
  return value
    .replace(/[^0-9]/g, "")
    .replace(/^(\d{0,2})(\d{0,2})$/g, "$1:$2")
    .replace(/(\:{1,2})$/g, "");
}

function isValidTime(startTime, endTime) {
  // 단독으로 전달된 startTime 검사
  if (startTime && !endTime) {
    return timeRegex.test(startTime);
  }

  // 단독으로 전달된 endTime 검사
  if (endTime && !startTime) {
    return timeRegex.test(endTime);
  }

  // 두 값이 모두 전달된 경우
  if (startTime && endTime) {
    if (!timeRegex.test(startTime) || !timeRegex.test(endTime)) {
      return false;
    }

    const startNumeric = parseInt(startTime.replace(/[^0-9]/g, ""), 10);
    const endNumeric = parseInt(endTime.replace(/[^0-9]/g, ""), 10);
    return startNumeric < endNumeric;
  }

  // 두 값이 모두 전달되지 않은 경우
  return false;
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
