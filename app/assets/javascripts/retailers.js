$(document).ready(function(){
    $('#show-booking-form').click(function () {
        $('html,body').animate({
            scrollTop: $(".book-styling").offset().top
        });
    });

    $('.store-referral-form').hide();

    $('#show-store-referral-form').click(function () {
        $('.store-referral-form').toggle();
    });
});
