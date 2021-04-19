document.addEventListener("turbolinks:load", function () {

    let loginSubmitButton = document.getElementsByClassName('js-login-submit')[0];
    let loginEmailButton = document.getElementsByClassName('js-login-email')[0];
    let loginPasswordButton = document.getElementsByClassName('js-login-password')[0];
    // loginSubmitButton.disabled = true;

    // focus and blur event (blur: out of focus)
    loginEmailButton.addEventListener('focus', function () {
        $("#js-login-title").css("color", "#0886e0");
    });

    loginEmailButton.addEventListener('blur', function () {
        $("#js-login-title").css("color", "black");
    });

    loginPasswordButton.addEventListener('focus', function () {
        $("#js-login-title").css("color", "#0886e0");
    });

    loginPasswordButton.addEventListener('blur', function () {
        $("#js-login-title").css("color", "black");
    });

    // validation check
    // loginEmailButton.addEventListener('keyup', function () {
    //     console.log(this.value.length);
    //     console.log(this.value);
    //     // email string has @?
    //     if (this.value.length < 2 || !this.value.match(/@/)) {
    //         loginSubmitButton.disabled = true;
    //     } else {
    //         loginSubmitButton.disabled = false;
    //     }
    // }, false);

    // loginPasswordButton.addEventListener('keyup', function () {
    //     console.log(this.value.length);
    //     if (this.value.length < 6) {
    //         loginSubmitButton.disabled = true;
    //     } else {
    //         loginSubmitButton.disabled = false;
    //     }
    // }, false);

});