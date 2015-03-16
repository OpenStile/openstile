function showLoadingImage() {
  $('div.logo').hide();
  $('div.logo-loading').show();
}

function hideLoadingImage() {
  $('div.logo-loading').hide();
  $('div.logo').show();
}

$(document).ready(function() {
  hideLoadingImage();

  $(".logo #style-feed-link").click(function() {
    showLoadingImage();
  });
});
