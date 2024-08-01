// =========================================ASIDE========================================= //
var asideBtn = document.getElementById("aside_btn");
var aside = document.getElementById("aside");
var profileBox = document.getElementById("profile_box");
var memberBox = document.querySelector(".member_box");
var accountBtnBox = document.querySelector(".account_btn_box");
var isOpened = false;

asideBtn.addEventListener("click", () => {
  if (!isOpened) {
    aside.style.width = "340px"; /* 확장된 너비 설정 */
    profileBox.classList.remove("hide");
    memberBox.classList.remove("hide");
    accountBtnBox.classList.remove("hide");
    profileBox.classList.add("show");
    memberBox.classList.add("show");
    accountBtnBox.classList.add("show");
    isOpened = true;
  } else {
    aside.style.width = "100px"; /* 축소된 너비 설정 */
    profileBox.classList.remove("show");
    memberBox.classList.remove("show");
    accountBtnBox.classList.remove("show");
    profileBox.classList.add("hide");
    memberBox.classList.add("hide");
    accountBtnBox.classList.add("hide");
    isOpened = false;
  }
});

// ======================================================================================= //

// =========================================CALAENDER===================================== //
var leftBtn = document.getElementById("left_btn");
var rightBtn = document.getElementById("right_btn");
var year = document.getElementById("year");
var month = document.getElementById("month");

leftBtn.addEventListener("click", () => {
  var currentYear = parseInt(year.innerText);
  year.innerText = currentYear - 1 + "년";
  location.href =
    "../PAGE/SchedulePage.jsp?year=" +
    (currentYear - 1) +
    "&month=" +
    monthButton.innerText +
    "&idx=" +
    idx;
});

rightBtn.addEventListener("click", () => {
  var currentYear = parseInt(year.innerText);
  year.innerText = currentYear + 1 + "년";
  location.href =
    "../PAGE/SchedulePage.jsp?year=" +
    (currentYear + 1) +
    "&month=" +
    monthButton.innerText +
    "&idx=" +
    idx;
});
// ======================================================================================= //

// ========================================logOut========================================= //
var logOutBtn = document.getElementById("log_out_btn");
logOutBtn.addEventListener("click", () => {
  var result = confirm("로그아웃하시겠습니까?");
  if (result) {
    location.href = "../ACTION/LogOutAction.jsp";
  }
});
//========================================================================================//

// ======================================= editProfile ==================================== //
var editProfileBtn = document.getElementById("edit_profile_btn");
editProfileBtn.addEventListener("click", () => {
  location.href = "../PAGE/UpdateAccountPage.jsp";
});
//===========================================================================================//

// ======================================= alert 출력 ==================================== //
window.addEventListener("load", () => {
  const urlParams = new URLSearchParams(window.location.search);
  const alertMessage = urlParams.get("alert");
  if (alertMessage) {
    alert(alertMessage);
    window.history.replaceState(null, "", window.location.pathname);
  }
});
//===========================================================================================//

// ======================================= 월 선택 모달 출력 ================================= //
// 월 모달 띄우고 닫기
var monthButton = document.getElementById("month");
var monthSelector = document.getElementById("month_selector");
monthButton.addEventListener("click", () => {
  if (monthSelector.classList.contains("hide")) {
    monthSelector.classList.remove("hide");
  } else {
    monthSelector.classList.add("hide");
  }
});

// 월 모달에서 선택하기
var monthList = monthSelector.getElementsByTagName("button");
Array.from(monthList).forEach((element) => {
  element.addEventListener("click", () => {
    monthButton.innerText = element.innerText + "월";
    monthSelector.classList.add("hide");
    location.href =
      "../PAGE/SchedulePage.jsp?month=" +
      element.innerText +
      "&idx=" +
      idx +
      "&year=" +
      year.innerText;
  });
});

// 월 모달 켜놓은 상태에서 바깥쪽 클릭 시 모달 닫음
document.addEventListener("click", (event) => {
  if (!monthSelector.contains(event.target) && event.target !== monthButton) {
    monthSelector.classList.add("hide");
  }
});
//===========================================================================================//

// ======================================= 홈 버튼 ========================================== //
var homeBtn = document.getElementById("home_btn");
homeBtn.addEventListener("click", () => {
  location.href = "../PAGE/SchedulePage.jsp";
});
//===========================================================================================//

// ======================================= 날짜 클릭 버튼 ========================================== //
var gridItem = document.querySelectorAll(".grid_item");
Array.from(gridItem).forEach((element) => {
  element.addEventListener("click", () => {
    location.href =
      "../PAGE/SelectSchedulePage.jsp?key=0" +
      "&year=" +
      year.innerText +
      "&month=" +
      month.innerText +
      "&day=" +
      element.dataset.day +
      "&idx=" +
      idx;
  });
});
//===========================================================================================//
