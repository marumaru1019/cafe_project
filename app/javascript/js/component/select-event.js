document.addEventListener("turbolinks:load", function () {

    let $selectBefore  = $("#js-select-before");
    let $selectAfter = $("#js-select-after");
    let $eventBefore = $("#js-event-before");
    let $eventAfter = $("#js-event-after");


    $selectBefore.css("color", "#FF5252");
    $selectBefore.css("font-size", "2em");
    $eventAfter.css("display", "none");

    $selectBefore.click(function () {
        $selectBefore.css("color", "#FF5252");
        $selectBefore.css("font-size", "2em");
        $selectAfter.css("color", "");
        $selectAfter.css("font-size", "");
        $eventAfter.fadeOut(100);
        $eventBefore.fadeIn(100);
    });

    $selectAfter.click(function () {
        $selectAfter.css("color", "#FF5252");
        $selectAfter.css("font-size", "2em");
        $selectBefore.css("color", "");
        $selectBefore.css("font-size", "");
        $eventBefore.fadeOut(100);
        $eventAfter.fadeIn(100);
    });

});