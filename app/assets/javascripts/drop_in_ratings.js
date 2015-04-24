$(document).ready(function() {
  $(".rating-form").hide();
  $(".edit-rating a").click(function() {
    event.preventDefault();
    var dropInId = "drop_in_" + $(this).data("drop-in-id");
    $("#" + dropInId + " .rating-summary").hide();
    $("#" + dropInId + " .rating-form").show();
  });
});

