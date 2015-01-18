//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.

function populateSizes (div, endpoints, options) {
  div.empty();
  if(options.length != 0) {
    div.append(endpoints[0]);
    div.append(options);
  }
  div.append(endpoints[1]);
  div.show();
}

function filterSizes (options, topLevelSelections) {
  var filtered = [];
  topLevelSelections.toArray().forEach(function(elem) {
    var parentId = elem.value;
    options.toArray().forEach(function(nestedElem) {
      if (nestedElem.className.match(parentId) != null) {
        filtered.push(nestedElem);
      }
    });
  });
  return filtered;
}

$(document).ready(function() {
  var topSizeNumericOptions = $("#top_sizes .numeric-sizes .single-checkbox");                                
  var bottomSizeNumericOptions = $("#bottom_sizes .numeric-sizes .single-checkbox");                                
  var bottomSizeInchOptions = $("#bottom_sizes .inch-sizes .single-checkbox");                                
  var dressSizeNumericOptions = $("#dress_sizes .numeric-sizes .single-checkbox");                                

  var topSizeNumericEndpoints = [$("#top_sizes .numeric-sizes h4"), 
                                $("#top_sizes .numeric-sizes input[type='hidden']")];

  var bottomSizeNumericEndpoints = [$("#bottom_sizes .numeric-sizes h4"), 
                                   $("#bottom_sizes .numeric-sizes input[type='hidden']")];

  var bottomSizeInchEndpoints = [$("#bottom_sizes .inch-sizes h4"), 
                                $("#bottom_sizes .inch-sizes input[type='hidden']")];

  var dressSizeNumericEndpoints = [$("#dress_sizes .numeric-sizes h4"), 
                                  $("#dress_sizes .numeric-sizes input[type='hidden']")];

  function populateTopSizes () {
    filtered_options = filterSizes(topSizeNumericOptions, $("#top_sizes .alpha-sizes input:checked"));
    populateSizes($("#top_sizes .numeric-sizes"), topSizeNumericEndpoints, filtered_options);
  }
  function populateBottomSizes () {
    numeric_filtered_options = filterSizes(bottomSizeNumericOptions, $("#bottom_sizes .alpha-sizes input:checked"));
    inch_filtered_options = filterSizes(bottomSizeInchOptions, $("#bottom_sizes .alpha-sizes input:checked"));
    populateSizes($("#bottom_sizes .numeric-sizes"), bottomSizeNumericEndpoints, numeric_filtered_options);
    populateSizes($("#bottom_sizes .inch-sizes"), bottomSizeInchEndpoints, inch_filtered_options);
  }
  function populateDressSizes () {
    filtered_options = filterSizes(dressSizeNumericOptions, $("#dress_sizes .alpha-sizes input:checked"));
    populateSizes($("#dress_sizes .numeric-sizes"), dressSizeNumericEndpoints, filtered_options);
  }

  populateTopSizes();
  populateBottomSizes();
  populateDressSizes();

  $("#top_sizes .alpha-sizes input:checkbox").change(populateTopSizes);
  $("#bottom_sizes .alpha-sizes input:checkbox").change(populateBottomSizes);
  $("#dress_sizes .alpha-sizes input:checkbox").change(populateDressSizes);
});
