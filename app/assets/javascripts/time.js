$(document).ready(function(){
  var matchTimes = $(".match-link")

  for (var counter = 0; counter < matchTimes.length; counter++) {
      var startTime = matchTimes[counter]
      var localTime = new Date(startTime.text)
      startTime.text = localTime.toLocaleString()
  }

})
