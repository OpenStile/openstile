//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.

function showLook (id) {
  $('.look').hide();
  $('#'+id).show();
}

function manageLookLinks (idx, max) {
  if (idx == 0){
    $(".showPreviousLook").attr("disabled",true);
  }
  else {
    $(".showPreviousLook").attr("disabled",false);
  }

  if (idx == max){
    $(".showNextLook").attr("disabled",true);
  }
  else {
    $(".showNextLook").attr("disabled",false);
  }
}

$(document).ready(function() {
  var lookIds = jQuery.map($(".look"), function(elem){ return elem.id });
  var currentLook = 0;

  showLook(lookIds[currentLook]);
  manageLookLinks(currentLook, lookIds.length -1)

  $(".showNextLook").click(function() {
    console.log("Next look clicked");
    event.preventDefault();
    if (currentLook != (lookIds.length - 1)){
      console.log("Still more looks");
      currentLook++;
    }
    showLook(lookIds[currentLook]);
    manageLookLinks(currentLook, lookIds.length -1)
  });  

  $(".showPreviousLook").click(function() {
    console.log("Previous look clicked");
    event.preventDefault();
    if (currentLook != 0){
      console.log("Still more looks");
      currentLook--;
    }
    showLook(lookIds[currentLook]);
    manageLookLinks(currentLook, lookIds.length -1)
  });  
});  
