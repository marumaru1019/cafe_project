
document.addEventListener("turbolinks:load", function () {
    $("#js-ham").click(function () {
        $("#js-ham").toggleClass('is-active');
        $("#js-modal").toggleClass("open");
    });
    $("#js-ham-xs").click(function () {
        $("#js-ham-xs").toggleClass('is-active');
        $("#js-modal").toggleClass("open");
    });
});
