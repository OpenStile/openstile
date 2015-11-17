$(document).ready(function(){
    $('#show-how-it-works').click(function () {
        $('html,body').animate({
            scrollTop: $(".how-it-works").offset().top
        });
    });
});
