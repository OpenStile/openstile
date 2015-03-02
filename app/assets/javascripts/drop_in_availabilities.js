//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.

var selectedDate;

function pushSelectedDate(elem) {
  elem.css('background-color', '#e2e2e2');
  selectedDate = elem;
}

function popSelectedDate() {
  if (selectedDate != null) {
    selectedDate.css('background-color', 'white');
  }
  selectedDate = null;
}

function setupTimepicker() {
  $('.drop-in-availability .timepicker').pickatime({
    formatSubmit: 'HH:i',
    hiddenName: true,
    min: [6,0],
    max: [23,0]
  })
}

function setStatusOptions() {
  var checkedStatus = $('.drop-in-availability .status input:radio:checked')

  if(checkedStatus.length > 0 && checkedStatus[0].value == "on"){
    $('#status-on-options').show();
  }
  else {
    $('#status-on-options').hide();
  }
}

$(document).ready(function() {
  $('#calendar').fullCalendar({
    fixedWeekCount: false,
    header: {
      left: 'prev,next',
      center: 'title',
      right: 'today'
    },
    dayClick: function(date, jsEvent, view) {
      popSelectedDate();
      pushSelectedDate($(this));
      $.ajax({
        url: "/drop_in_availabilities/apply_form",
        data: {date: date.format()}
      }).done(function (){
        console.log("Availability form applied for date")
      });
    },
    eventSources: [
      {
        url: '/retailers/' + $('#calendar').data("retailer-id") + "/scheduled_availabilities",
        textColor: 'white'
      }
    ]
  })

  setupTimepicker(); 
  setStatusOptions();
  $('.drop-in-availability .status input:radio').change(setStatusOptions);

});
