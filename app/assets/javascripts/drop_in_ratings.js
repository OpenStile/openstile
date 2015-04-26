$(document).ready(function() {
  $(".rating-form").hide();
  $(".edit-rating a").click(function() {
    event.preventDefault();
    var dropInId = "drop_in_" + $(this).data("drop-in-id");
    $("#" + dropInId + " .rating-summary").hide();
    $("#" + dropInId + " .rating-form").show();
  });

  $(".preferences-details").hide();
  $(".show-preferences-link").click(function() {
    event.preventDefault();
    var dropInId = "drop_in_" + $(this).data("drop-in-id");
    $("#" + dropInId + " .show-preferences-link").hide();
    $("#" + dropInId + " .preferences-details").show();
  });
  $(".hide-preferences-link").click(function() {
    event.preventDefault();
    var dropInId = "drop_in_" + $(this).data("drop-in-id");
    $("#" + dropInId + " .preferences-details").hide();
    $("#" + dropInId + " .show-preferences-link").show();
  });
});

