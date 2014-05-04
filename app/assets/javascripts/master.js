
// Infinite Scroll Functionality

var incrementVal = 10;
var searchVal;
var scrollInterval;

function checkScroll() {
  if (searchVal) {
    if (nearBottomOfPage()) {
      if (incrementVal < 100) {
        incrementVal += 10;
        console.log("Tweets Displayed: " + (incrementVal));
        $.get("/searches/", {search: searchVal, increment: incrementVal}, null, 'script');
      } else {
        console.log("Max number of tweets displayed! Sorry! You'll have to bother those Twitter guys about that.");
        clearInterval(scrollInterval);
      };
    };
  };
};

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 100;
};

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
};

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
};

//END


// Ready & Page:Load Function

var ready;
ready = function() {
  searchVal = $("#search").val();
  scrollInterval = setInterval("checkScroll()", 1000);
};

$(document).ready(ready);
$(document).on('page:load', ready);

//END