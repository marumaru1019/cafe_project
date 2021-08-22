document.addEventListener("turbolinks:load", function () {

  let noticeText = $(".js-alert").text().trim();

  // trim : remove blank
  if (noticeText.length <= 0) {
    $(".js-alert").css("display", "none");
  }
});
