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
});

rightBtn.addEventListener("click", () => {
  var currentYear = parseInt(year.innerText);
  year.innerText = currentYear + 1 + "년";
});
// ======================================================================================= //

// ========================================logOut========================================= //
var logOutBtn = document.getElementById("log_out_btn");
logOutBtn.addEventListener("click", () => {
  var result = confirm("로그아웃하시겠습니까?");
  if (result) {
    location.href = "../index.jsp";
  }
});
//============================================================================//

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
var monthButton = document.getElementById("month");
var monthSelector = document.getElementById("month_selector");
monthButton.addEventListener("click", () => {
  if (monthSelector.classList.contains("hide")) {
    monthSelector.classList.remove("hide");
  } else {
    monthSelector.classList.add("hide");
  }
});

var monthList = monthSelector.getElementsByTagName("button");
Array.from(monthList).forEach((element) => {
  element.addEventListener("click", () => {
    monthButton.innerText = element.innerText + "월";
    monthSelector.classList.add("hide");
  });
});

document.addEventListener("click", (event) => {
  // monthButton이나 monthSelector 내부를 클릭한 경우 아무 작업도 하지 않음
  if (!monthSelector.contains(event.target) && event.target !== monthButton) {
    monthSelector.classList.add("hide");
  }
});
//===========================================================================================//

// ======================================= 홈 버튼 ================================= //
var homeBtn = document.getElementById("home_btn");
homeBtn.addEventListener("click", () => {
  location.href = "../PAGE/SchedulePage.jsp";
});
