const date = document.getElementById("date").innerText;
const [, year, month, day] = date.match(/(\d{4})년 (\d{1,2})월 (\d{1,2})일/);

const submitButton = createSubmitButton();
const cancelBtn = createCancelBtn();

var editButtons = document.querySelectorAll(".edit_schedule");
Array.from(editButtons).forEach((element) => {
  element.addEventListener("click", editEvent);
});

var deleteButtons = document.querySelectorAll(".delete_schedule");
Array.from(deleteButtons).forEach((element) => {
  element.addEventListener("click", deleteEvent);
});

function deleteEvent(event) {
  var idx = event.target.closest(".schedule").dataset.scheduleIdx;
  var deleteConfirm = confirm("일정을 삭제하시겠습니까?");
  if (deleteConfirm) {
    location.href =
      "../ACTION/DeleteScheduleAction.jsp?idx=" +
      idx +
      "&year=" +
      year +
      "&month=" +
      month +
      "&day=" +
      day;
  }
}

function editEvent(event) {
  var schedule = event.target.closest(".schedule");
  var scheduleIdx = schedule.dataset.scheduleIdx;
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
  itemBox.replaceChild(cancelBtn, deleteButtons[scheduleIdx]);
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
    var idx = schedule.dataset.scheduleIdx;
    var inputTag = schedule.querySelector(".edit_schedule_input");
    location.href =
      "../ACTION/UpdateScheduleAction.jsp?idx=" +
      idx +
      "&year=" +
      year +
      "&month=" +
      month +
      "&day=" +
      day +
      "&content=" +
      inputTag.value;
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
    var scheduleIdx = schedule.dataset.scheduleIdx;
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
    itemBox.replaceChild(editButtons[scheduleIdx], submitButton);
    itemBox.replaceChild(deleteButtons[scheduleIdx], cancelBtn);
    itemBox.replaceChild(startTime, startTimeInputTag);
    itemBox.replaceChild(endTime, endTimeInputTag);
  }
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

// inputStartTime.addEventListener("blur", () => {
//   if (!isValidTime(inputStartTime.value)) {
//     alert("00:00~23:59까지 입력 가능합니다");
//   }
// });

// inputEndTime.addEventListener("blur", () => {
//   if (!isValidTime(inputEndTime.value)) {
//     alert("00:00~23:59까지 입력 가능합니다");
//   } else if (!isValidTime(inputStartTime.value, inputEndTime.value)) {
//     alert("종료시간은 시작시간 이후여야 합니다.");
//   }
// });

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

// ================================================================================================================ //
