// ======================================== 전역변수 선언 ==============================================
const date = document.getElementById("date").innerText;
const [, year, month, day] = date.match(/(\d{4})년 (\d{1,2})월 (\d{1,2})일/);
let submitBtns = [];
let cancelBtns = [];
var editButtons = document.querySelectorAll(".edit_schedule");
var deleteButtons = document.querySelectorAll(".delete_schedule");
// =========================================================================================================

// ==================================== 지난 일정 회색 처리 ============================================
var schedules = document.querySelectorAll(".schedule");
Array.from(schedules).forEach((element) => {
  var endTime = element.querySelector(".edit_end_time_input").innerText;
  if (currentTime > endTime) {
    var endScheduleContent = element.querySelector(".schedule_content");
    element.classList.add("end_schedule_background");
    endScheduleContent.classList.add("end_schedule_content");
  }
});
// =========================================================================================================

// ============================================= 요소 동적 생성 ============================================
for (var index = 0; index < editButtons.length; index++) {
  submitBtns.push(createSubmitButton());
  cancelBtns.push(createCancelBtn());
}

function createSubmitButton() {
  var submitButton = document.createElement("button");
  submitButton.classList.add("edit_schedule", "bold_text");
  submitButton.innerText = "완료";
  return submitButton;
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
  pTag.dataset.originalText = content;
  pTag.classList.add(style, "bold_text");
  return pTag;
}

function createCancelBtn() {
  var cancelBtn = document.createElement("button");
  cancelBtn.classList.add("delete_schedule", "bold_text");
  cancelBtn.innerText = "취소";
  return cancelBtn;
}
// =========================================================================================================

// ==========================================버튼 이벤트 등록================================================
Array.from(editButtons).forEach((element, index) => {
  element.addEventListener("click", (event) => editEvent(event, index));
});

Array.from(deleteButtons).forEach((element) => {
  element.addEventListener("click", (event) => deleteEvent(event));
});

Array.from(submitBtns).forEach((element) => {
  element.addEventListener("click", (event) => submitEvent(event));
});

Array.from(cancelBtns).forEach((element, index) => {
  element.addEventListener("click", (event) => cancelEvent(event, index));
});

function deleteEvent(event) {
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
  itemBox.replaceChild(submitBtns[index], event.target);
  itemBox.replaceChild(cancelBtns[index], deleteButtons[index]);
  itemBox.replaceChild(startTimeInputTag, startTime);
  itemBox.replaceChild(endTimeInputTag, endTime);
  schedule.replaceChild(contentInputTag, contentTag);
}

function submitEvent(event) {
  var submitConfirm = confirm("일정을 수정하시겠습니까?");
  if (submitConfirm) {
    var schedule = event.target.closest(".schedule");
    var scheduleIdx = schedule.dataset.scheduleIdx;
    var content = schedule.querySelector(".edit_schedule_input");
    var startTime = schedule.querySelector(".edit_start_time_input");
    var endTime = schedule.querySelector(".edit_end_time_input");

    // 입력값이 변했는지 체크
    var anyChanged = isValuesChanged([content, startTime, endTime]);
    if (!anyChanged) {
      alert(
        "일정을 수정하려면, 시작시간, 종료시간, 일정 내용 중 한개 이상을 변경해야 합니다"
      );
      return;
    }
    // 이런건 고객의 편의가 더 중요하지 않나 ..

    // 입력값 유효성 검사 및 수정 진행
    // idx는 세션에 있는 값을 사용하면 되는데, 굳이 query로 보내야 할 이유가 없다
    try {
      isValidateContent(content.value);
      isValidateTime(startTime.value, "시작시간");
      isValidateTime(endTime.value, "종료시간");
      isValidateTimeRelationship(startTime.value, endTime.value);
      location.href =
        "../ACTION/UpdateScheduleAction.jsp?schedule_idx=" +
        scheduleIdx +
        "&writer=" +
        idx +
        "&year=" +
        year +
        "&month=" +
        month +
        "&day=" +
        day +
        "&start_time=" +
        startTime.value +
        "&end_time=" +
        endTime.value +
        "&content=" +
        content.value;
    } catch (error) {
      alert(error.message);
    }
  }
}

function cancelEvent(event, index) {
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
    itemBox.replaceChild(editButtons[index], submitBtns[index]);
    itemBox.replaceChild(deleteButtons[index], cancelBtns[index]);
    itemBox.replaceChild(startTime, startTimeInputTag);
    itemBox.replaceChild(endTime, endTimeInputTag);
  }
}
// ===============================================================================================================

// ==============================================일정 추가 영역 이벤트=============================================== //
var inputScheduleBox = document.getElementById("input_schedule_box");
// 입력 영역이 있을때만 코드 실행
if (inputScheduleBox) {
  var content = document.getElementById("input_content");
  var startTime = document.getElementById("input_start");
  var endTime = document.getElementById("input_end");
  var inputScheduleBtn = document.getElementById("input_schedule_btn");

  // 시간 입력 형식 자동변환
  startTime.addEventListener("input", () => {
    startTime.value = timeRegexForm(startTime.value);
  });
  endTime.addEventListener("input", () => {
    endTime.value = timeRegexForm(endTime.value);
  });

  // 입력값 유효성 검사 및 입력 추가 진행
  inputScheduleBtn.addEventListener("click", () => {
    try {
      isValidateContent(content.value);
      isValidateTime(startTime.value, "시작시간");
      isValidateTime(endTime.value, "종료시간");
      isValidateTimeRelationship(startTime.value, endTime.value);
      location.href =
        "../ACTION/CreateScheduleAction.jsp?content=" +
        content.value +
        "&start_time=" +
        startTime.value +
        "&end_time=" +
        endTime.value +
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
}
// ================================================================================================================ //

// ==============================================뒤로가기 버튼 이벤트=============================================== //
window.history.pushState({ page: 2 }, "SelectSchedulePage", location.href);
console.log(window.history.state);
window.addEventListener("popstate", () => {
  window.location.href =
    "../PAGE/SchedulePage.jsp?idx=" + idx + "&year=" + year + "&month=" + month;
});
// ================================================================================================================ //
