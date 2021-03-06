$(document).ready(function() {
  $(".rating-form").hide();
  $(".edit-rating a").click(function() {
    event.preventDefault();
    var dropInId = "drop_in_" + $(this).data("drop-in-id");
    $("#" + dropInId + " .rating-summary").hide();
    $("#" + dropInId + " .rating-form").show();
  });

  $(".preferences-details").hide();

  $('.bookings .show-preferences-toggle').click(function(){
    $(this).toggleClass('fa-caret-down')
    $(this).toggleClass('fa-caret-right');
    if ($(this).is('.fa-caret-down')) {
        $(this).closest('.content').find('.preferences-details').show();
    } else {
        $(this).closest('.content').find('.preferences-details').hide();
    }
  });
});

