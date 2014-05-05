
// Ready & Page:Load Function

var ready;
ready = function() {
  $("a.fancybox").fancybox({
    padding: 0,
    helpers: {
      overlay: {
        locked: false
      }
    }
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);

//END