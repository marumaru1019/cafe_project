console.log('hello world');

$('#toggle').click(function () {
    $(this).toggleClass('active');
    $('#overlay').toggleClass('open');
    console.log('hello world');
});