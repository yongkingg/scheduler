const date = document.getElementById("date").innerText;
const [, year, month, day] = date.match(/(\d{4})년 (\d{1,2})월 (\d{1,2})일/);
var editButtons = document.querySelectorAll(".edit_schedule");
Array.from(editButtons).forEach((element) => {
  element.addEventListener("click", editEvent);
});

function editEvent(event) {
  console.log(event.target);
}

var deleteButtons = document.querySelectorAll(".delete_schedule");
Array.from(deleteButtons).forEach((element) => {
  element.addEventListener("click", deleteEvent);
});

function deleteEvent(event) {
  var deleteScheduleIdx = event.target.closest(".schedule").dataset.scheduleIdx;
  var deleteConfirm = confirm("일정을 삭제하시겠습니까?");
  if (deleteConfirm) {
    location.href =
      "../ACTION/DeleteScheduleAction.jsp?idx=" +
      deleteScheduleIdx +
      "&year=" +
      year +
      "&month=" +
      month +
      "&day=" +
      day;
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
