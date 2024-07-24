var editButtons = document.getElementsByClassName("edit_schedule");

Array.from(editButtons).forEach(function (editButton) {
  editButton.addEventListener("click", function () {
    var scheduleDiv = this.closest(".schedule");
    var scheduleContent = scheduleDiv.querySelector(".schedule_content");
    var deleteBtn = scheduleDiv.querySelector(".delete_schedule");
    var itemBox = scheduleDiv.querySelector(".schedule_item_box");

    if (!scheduleContent) {
      return;
    }

    if (scheduleContent.tagName === "P") {
      toggleContentTag(scheduleDiv, scheduleContent, true);
      if (itemBox && deleteBtn) {
        toggleButtonState(itemBox, deleteBtn, "취소");
      }
    } else if (scheduleContent.tagName === "INPUT") {
      if (confirm("수정을 취소하시겠습니까?")) {
        toggleContentTag(scheduleDiv, scheduleContent, false);
        if (itemBox) {
          toggleButtonState(itemBox, this, "삭제");
        }
      }
    }
  });
});

function toggleContentTag(parentElement, content, toInput) {
  if (toInput) {
    // p to input
    var inputTag = document.createElement("input");
    inputTag.value = content.textContent;
    inputTag.classList.add("edit_schedule_input", "bold_text");
    inputTag.dataset.originalText = content.textContent; // 기존 값 저장
    parentElement.replaceChild(inputTag, content);
  } else {
    // input to p
    var originalText = content.dataset.originalText;
    var tmpPTag = document.createElement("p");
    tmpPTag.textContent = originalText;
    tmpPTag.classList.add("schedule_content");
    parentElement.replaceChild(tmpPTag, content);
  }
}

function toggleButtonState(parentElement, button, state) {
  var newButton = document.createElement("button");
  newButton.classList.add("delete_schedule", "bold_text");

  if (state === "취소") {
    newButton.innerText = "취소";
    newButton.addEventListener("click", function () {
      if (confirm("수정을 취소하시겠습니까?")) {
        var inputTag = parentElement.parentElement.querySelector(
          ".edit_schedule_input"
        );
        if (inputTag) {
          toggleContentTag(parentElement.closest(".schedule"), inputTag, false);
        }
        toggleButtonState(parentElement, this, "삭제");
      }
    });
  } else if (state === "삭제") {
    newButton.innerText = "삭제";
  }

  parentElement.replaceChild(newButton, button);
}
