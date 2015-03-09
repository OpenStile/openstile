function showAdditionalItems() {
  $('.view-more .additional').show();
  $('.view-more #less').show();
  $('.view-more #additional').hide();
}

function showFewerItems() {
  $('.view-more .additional').hide();
  $('.view-more #less').hide();
  $('.view-more #additional').show();
}

$(document).ready(function() {
  showFewerItems();

  $('.view-more #additional').click(function() {
    event.preventDefault();
    showAdditionalItems();
  });

  $('.view-more #less').click(function() {
    event.preventDefault();
    showFewerItems();
  });
});
