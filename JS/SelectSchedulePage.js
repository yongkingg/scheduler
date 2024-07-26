var editButtons = document.getElementsByClassName("edit_schedule");
Array.from(editButtons).forEach((element) => {
  element.addEventListener("click", editEvent);
});

function editEvent(event) {
  var scheduleDiv = event.target.closest(".schedule");
  var scheduleContent = scheduleDiv.querySelector(".schedule_content");
  if (scheduleContent) {
    var deleteBtn = scheduleDiv.querySelector(".delete_schedule");
    var itemBox = scheduleDiv.querySelector(".schedule_item_box");
    switchContentTag(scheduleDiv, scheduleContent, true);
    switchButton(itemBox, deleteBtn, "취소");
  } else if (scheduleDiv.querySelector("input")) {
    var content = scheduleDiv.querySelector("input");
    switchContentTag(scheduleDiv, content, false, true);
  }
}

var deleteButtons = document.getElementsByClassName("delete_schedule");
Array.from(deleteButtons).forEach((element) => {
  element.addEventListener("click", deleteEvent);
});

function deleteEvent() {
  if (confirm("일정을 삭제하시겠습니까?")) {
    location.href = "../PAGE/SelectSchedulePage.jsp?key=0";
    alert("일정이 삭제되었습니다.");
  }
}

// 컨텐츠 태그 전환
function switchContentTag(parentElement, content, toInput) {
  if (toInput) {
    var inputTag = createInputTag(content);
    parentElement.replaceChild(inputTag, content);
  } else {
    var pTag = createParagraphTag(content);
    parentElement.replaceChild(pTag, content);
  }
}

// 입력 태그 생성
function createInputTag(content) {
  var inputTag = document.createElement("input");
  inputTag.value = content.textContent;
  inputTag.classList.add("edit_schedule_input", "bold_text");
  inputTag.dataset.originalText = content.textContent; // 기존 값 저장
  return inputTag;
}

// 문단 태그 생성
function createParagraphTag(content) {
  var originalText;
  if (content.value == content.dataset.originalText) {
    originalText = content.dataset.originalText;
  } else {
    originalText = content.value;
  }
  var pTag = document.createElement("p");
  pTag.textContent = originalText;
  pTag.classList.add("schedule_content");
  return pTag;
}

// 버튼 생성
function createButton(state) {
  var button = document.createElement("button");
  button.classList.add("delete_schedule", "bold_text");
  button.innerText = state;
  return button;
}

// 버튼 전환
function switchButton(parentElement, button, state) {
  var newButton = createButton(state);
  if (state === "취소") {
    newButton.addEventListener("click", () => {
      if (confirm("수정을 취소하시겠습니까?")) {
        var inputTag = parentElement.parentElement.querySelector(
          ".edit_schedule_input"
        );
        if (inputTag) {
          switchContentTag(parentElement.closest(".schedule"), inputTag, false);
        }
        switchButton(parentElement, newButton, "삭제");
      }
    });
  }
  parentElement.replaceChild(newButton, button);
}

// ==================================================일정 추가====================================================== //
var inputContent = document.getElementById("input_content");
var inputStartTime = document.getElementById("input_start");
var inputEndTime = document.getElementById("input_end");
var inputScheduleBtn = document.getElementById("input_schedule_btn");

inputStartTime.addEventListener("input", () => {
  inputStartTime.value = timeRegexForm(inputStartTime.value);
});

inputEndTime.addEventListener("input", () => {
  inputEndTime.value = timeRegexForm(inputEndTime.value);
});

inputStartTime.addEventListener("blur", () => {
  if (!isValidTime(inputStartTime.value)) {
    alert("00:00~23:59까지 입력 가능합니다");
  }
});

inputEndTime.addEventListener("blur", () => {
  if (!isValidTime(inputEndTime.value)) {
    alert("00:00~23:59까지 입력 가능합니다");
  } else if (!isValidTime(inputStartTime.value, inputEndTime.value)) {
    alert("종료시간은 시작시간 이후여야 합니다.");
  }
});

inputScheduleBtn.addEventListener("click", () => {
  if (!isValidate(validationRules[4].regex, inputContent)) {
    alert(validationRules[4].message);
  } else if (
    !isValidTime(inputStartTime.value) ||
    !isValidTime(inputEndTime.value) ||
    !isValidTime(inputStartTime.value, inputEndTime.value)
  ) {
    alert("시간정보를 정확히 입력해 주세요");
  } else {
    location.href = "../ACTION/CreateScheduleAction.jsp";
  }
});

window.addEventListener("popstate", () => {
  console.log("123");
  document.querySelectorAll("input").forEach((input) => (input.value = ""));
});
// ================================================================================================================ //
