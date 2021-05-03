document.addEventListener("turbolinks:load", function () {
  $(function () {
    let loader = $('.loader-wrap');

    //ページの読み込みが完了したらアニメーションを非表示
    $(window).on('load', function () {
      loader.fadeOut();
    });

    //ページの読み込みが完了してなくても2秒後にアニメーションを非表示にする
    setTimeout(function () {
      loader.fadeOut();
    },1000);
  });
});