document.addEventListener("DOMContentLoaded", function () {
  var editButtons = document.getElementsByClassName("edit_schedule");

  Array.from(editButtons).forEach(function (editButton) {
    editButton.addEventListener("click", function () {
      var scheduleDiv = this.closest(".schedule");
      var scheduleContent = scheduleDiv.querySelector(".schedule_content");
      var deleteBtn = scheduleDiv.querySelector(".delete_schedule");
      var itemBox = scheduleDiv.querySelector(".schedule_item_box");

      if (scheduleContent.tagName === "P") {
        changePtoInputTag(scheduleDiv, scheduleContent);
        changeDeleteToCancelBtn(itemBox, deleteBtn);
      } else if (scheduleContent.tagName === "INPUT") {
        if (confirm("수정을 취소하시겠습니까?")) {
          changeInputToPTag(
            scheduleDiv,
            scheduleContent,
            scheduleContent.dataset.originalText
          );
          changeCancelToDeleteBtn(itemBox, this);
        }
      }
    });
  });

  function changePtoInputTag(parentElement, content) {
    var inputTag = document.createElement("input");
    inputTag.value = content.textContent;
    inputTag.classList.add("edit_schedule_input", "bold_text");
    inputTag.dataset.originalText = content.textContent; // Save the original text
    parentElement.replaceChild(inputTag, content);
  }

  function changeInputToPTag(parentElement, input, originalText) {
    var tmpPTag = document.createElement("p");
    tmpPTag.textContent = originalText; // Use the original text
    tmpPTag.classList.add("schedule_content");
    parentElement.replaceChild(tmpPTag, input);
  }

  function changeDeleteToCancelBtn(parentElement, btn) {
    var cancelBtn = document.createElement("button");
    cancelBtn.innerText = "취소";
    cancelBtn.classList.add("delete_schedule", "bold_text");
    cancelBtn.addEventListener("click", function () {
      if (confirm("수정을 취소하시겠습니까?")) {
        var inputTag = parentElement.parentElement.querySelector(
          ".edit_schedule_input"
        );
        if (inputTag) {
          changeInputToPTag(
            parentElement.closest(".schedule"),
            inputTag,
            inputTag.dataset.originalText
          );
        }
        changeCancelToDeleteBtn(parentElement, this);
      }
    });
    parentElement.replaceChild(cancelBtn, btn);
  }

  function changeCancelToDeleteBtn(parentElement, cancelBtn) {
    var deleteBtn = document.createElement("button");
    deleteBtn.innerText = "삭제";
    deleteBtn.classList.add("delete_schedule", "bold_text");
    parentElement.replaceChild(deleteBtn, cancelBtn);
  }
});
