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
