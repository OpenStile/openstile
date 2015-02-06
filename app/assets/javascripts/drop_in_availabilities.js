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

$(document).ready(function() {
  $('#calendar').fullCalendar({
    fixedWeekCount: false,
    eventBackgroundColor: '#428bca',
    header: {
      left: 'prev,next',
      center: 'title',
      right: 'today'
    },
    dayClick: function(date, jsEvent, view) {
      popSelectedDate();
      pushSelectedDate($(this));
      $('#date').val(date.format());
      $('#date').prop('readonly', true);
    },
    eventSources: [
      {
        url: '/retailers/' + $('#calendar').data("retailer-id") + "/scheduled_availabilities",
        rendering: 'background'
      }
    ]
  })

  $('.timepicker').pickatime({
    formatSubmit: 'HH:i',
    hiddenName: true,
    min: [6,0],
    max: [23,0]
  })
});
