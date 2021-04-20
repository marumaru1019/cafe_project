document.addEventListener("turbolinks:load", function () {

    let noticeText = $(".js-notice").text().trim();

    // trim : remove blank
    if ( noticeText.length <= 0 ) {
        $(".js-notice").css("display", "none");
    }

});
