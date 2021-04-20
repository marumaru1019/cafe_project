document.addEventListener("turbolinks:load", function () {

  $(".js-login-check").focusin(function () {
    $("#js-login-title").css("color", "#0886e0");
  });

  $(".js-login-check").focusout(function () {
    $("#js-login-title").css("color", "black");
  });

});
