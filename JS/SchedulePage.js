var asideBtn = document.getElementById("aside_btn");
var aside = document.getElementById("aside");
var profileBox = document.getElementById("profile_box");
var memberBox = document.querySelector(".member_box");
var accountBtnBox = document.querySelector(".account_btn_box");
var isClicked = false;

asideBtn.addEventListener("click", () => {
  if (!isClicked) {
    aside.style.width = "340px"; /* 확장된 너비 설정 */
    profileBox.classList.remove("hide");
    memberBox.classList.remove("hide");
    accountBtnBox.classList.remove("hide");
    profileBox.classList.add("show");
    memberBox.classList.add("show");
    accountBtnBox.classList.add("show");
    isClicked = true;
  } else {
    aside.style.width = "100px"; /* 축소된 너비 설정 */
    profileBox.classList.remove("show");
    memberBox.classList.remove("show");
    accountBtnBox.classList.remove("show");
    profileBox.classList.add("hide");
    memberBox.classList.add("hide");
    accountBtnBox.classList.add("hide");
    isClicked = false;
  }
});
