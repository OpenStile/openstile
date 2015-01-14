//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.

function showLook (id) {
  $('.look').hide();
  $('#'+id).show();
}

function manageLinks (idx, max) {
  if (idx == 0){
    $(".showPreviousLook").hide();
  }
  else {
    $(".showPreviousLook").show();
  }

  if (idx == max){
    $(".showNextLook").hide();
  }
  else {
    $(".showNextLook").show();
  }
}

$(document).ready(function() {
  var ids = jQuery.map($(".look"), function(elem){ return elem.id });
  var index = 0;

  showLook(ids[index]);
  manageLinks(index, ids.length -1)

  $(".showNextLook").click(function() {
    console.log("Next look clicked");
    event.preventDefault();
    if (index != (ids.length - 1)){
      console.log("Still more looks");
      index++;
    }
    showLook(ids[index]);
    manageLinks(index, ids.length -1)
  });  

  $(".showPreviousLook").click(function() {
    console.log("Previous look clicked");
    event.preventDefault();
    if (index != 0){
      console.log("Still more looks");
      index--;
    }
    showLook(ids[index]);
    manageLinks(index, ids.length -1)
  });  
});  
