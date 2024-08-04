const date = document.getElementById("date").innerText;
const [, year, month, day] = date.match(/(\d{4})년 (\d{1,2})월 (\d{1,2})일/);

const submitButton = createSubmitButton();
const cancelBtn = createCancelBtn();

let clickedBtnIdx;

var editButtons = document.querySelectorAll(".edit_schedule");
Array.from(editButtons).forEach((element, index) => {
  element.addEventListener("click", (event) => editEvent(event, index));
});

var deleteButtons = document.querySelectorAll(".delete_schedule");
Array.from(deleteButtons).forEach((element, index) => {
  element.addEventListener("click", (event) => deleteEvent(event, index));
});

function deleteEvent(event, index) {
  var deleteConfirm = confirm("일정을 삭제하시겠습니까?");
  var scheduleIdx =
    event.target.parentElement.parentElement.dataset.scheduleIdx;
  if (deleteConfirm) {
    location.href =
      "../ACTION/DeleteScheduleAction.jsp?schedule_idx=" +
      scheduleIdx +
      "&year=" +
      year +
      "&month=" +
      month +
      "&day=" +
      day +
      "&idx=" +
      idx;
  }
}

function editEvent(event, index) {
  var schedule = event.target.closest(".schedule");
  clickedBtnIdx = index;

  var contentTag = schedule.querySelector(".schedule_content");
  var startTime = schedule.querySelector(".edit_start_time_input");
  var endTime = schedule.querySelector(".edit_end_time_input");
  var contentInputTag = createInputTag(
    contentTag.innerText,
    "edit_schedule_input"
  );
  var startTimeInputTag = createInputTag(
    startTime.innerText,
    "edit_start_time_input"
  );
  var endTimeInputTag = createInputTag(
    endTime.innerText,
    "edit_end_time_input"
  );

  var itemBox = event.target.parentElement;
  itemBox.replaceChild(submitButton, event.target);
  itemBox.replaceChild(cancelBtn, deleteButtons[clickedBtnIdx]);
  itemBox.replaceChild(startTimeInputTag, startTime);
  itemBox.replaceChild(endTimeInputTag, endTime);
  schedule.replaceChild(contentInputTag, contentTag);
}

function createSubmitButton() {
  var submitButton = document.createElement("button");
  submitButton.classList.add("edit_schedule", "bold_text");
  submitButton.innerText = "완료";
  submitButton.addEventListener("click", submitEvent);
  return submitButton;
}

function submitEvent(event) {
  var submitConfirm = confirm("일정을 수정하시겠습니까?");
  if (submitConfirm) {
    var schedule = event.target.closest(".schedule");
    var scheduleIdx = schedule.dataset.scheduleIdx;
    var content = schedule.querySelector(".edit_schedule_input");
    var startTime = schedule.querySelector(".edit_start_time_input");
    var endTime = schedule.querySelector(".edit_end_time_input");
    location.href =
      "../ACTION/UpdateScheduleAction.jsp?schedule_idx=" +
      scheduleIdx +
      "&writer=" +
      idx +
      "&start_time=" +
      startTime.value +
      "&end_time=" +
      endTime.value +
      "&content=" +
      content.value;
  }
}

function createInputTag(content, style) {
  var inputTag = document.createElement("input");
  inputTag.value = content;
  inputTag.classList.add(style, "bold_text");
  if (
    inputTag.classList.contains("edit_start_time_input") ||
    inputTag.classList.contains("edit_end_time_input")
  ) {
    inputTag.addEventListener("input", () => {
      inputTag.value = timeRegexForm(inputTag.value);
    });
    inputTag.maxLength = "5";
  }
  inputTag.dataset.originalText = content;
  return inputTag;
}

function createPTag(content, style) {
  var pTag = document.createElement("p");
  pTag.textContent = content;
  pTag.classList.add(style, "bold_text");
  return pTag;
}

function createCancelBtn() {
  var cancelBtn = document.createElement("button");
  cancelBtn.classList.add("delete_schedule", "bold_text");
  cancelBtn.innerText = "취소";
  cancelBtn.addEventListener("click", cancelEvent);
  return cancelBtn;
}

function cancelEvent(event) {
  var deleteConfirm = confirm("수정을 취소하시겠습니까?");
  if (deleteConfirm) {
    var schedule = event.target.closest(".schedule");
    var inputTag = schedule.querySelector(".edit_schedule_input");
    var contentTag = createPTag(
      inputTag.dataset.originalText,
      "schedule_content"
    );

    var startTimeInputTag = schedule.querySelector(".edit_start_time_input");
    var endTimeInputTag = schedule.querySelector(".edit_end_time_input");
    var startTime = createPTag(
      startTimeInputTag.value,
      "edit_start_time_input"
    );
    var endTime = createPTag(endTimeInputTag.value, "edit_end_time_input");

    var itemBox = event.target.parentElement;
    schedule.replaceChild(contentTag, inputTag);
    itemBox.replaceChild(editButtons[clickedBtnIdx], submitButton);
    itemBox.replaceChild(deleteButtons[clickedBtnIdx], cancelBtn);
    itemBox.replaceChild(startTime, startTimeInputTag);
    itemBox.replaceChild(endTime, endTimeInputTag);
  }
}
// ==================================================일정 추가====================================================== //
var inputScheduleBox = document.getElementById("input_schedule_box");
if (inputScheduleBox) {
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

  inputScheduleBtn.addEventListener("click", () => {
    try {
      validateContent();
      validateTime(inputStartTime, "시작시간");
      validateTime(inputStartTime, "종료시간");
      validateTimeRelationship();
      location.href =
        "../ACTION/CreateScheduleAction.jsp?content=" +
        inputContent.value +
        "&start_time=" +
        inputStartTime.value +
        "&end_time=" +
        inputEndTime.value +
        "&writer=" +
        idx +
        "&year=" +
        year +
        "&month=" +
        month +
        "&day=" +
        day;
    } catch (error) {
      alert(error.message);
    }
  });

  function validateContent() {
    if (!isValidate(validationRules[4].regex, inputContent)) {
      throw new Error(validationRules[4].message);
    }
  }

  function validateTime(inputTime, key) {
    if (inputTime.value == "") {
      throw new Error(key + "을 입력해 주세요");
    }
    if (!isValidTime(inputTime.value)) {
      throw new Error("00:00~23:59까지 입력 가능합니다");
    }
  }

  function validateTimeRelationship() {
    if (!isValidTime(inputStartTime.value, inputEndTime.value)) {
      throw new Error("종료시각은 시작시간보다 이후로 설정해주세요");
    }
  }
}
// ================================================================================================================ //
window.history.pushState({ page: 2 }, "SelectSchedulePage", location.href);
console.log(window.history.state);
window.addEventListener("popstate", () => {
  window.location.href =
    "../PAGE/SchedulePage.jsp?idx=" + idx + "&year=" + year + "&month=" + month;
});

// action에서 history 제거
