// Ready & Page:Load Function

var ready;
ready = function() {

  // Initalize FancyBox Plugin
  $("a.fancybox").fancybox({
    padding: 0,
    helpers: {
      overlay: {
        locked: false
      }
    }
  });

  // Initialize Isotope Plugin
  var $images = $('#imgur-images');

  $images.isotope({
  });

  $('#user-hashtags a').click(function(){
    var selector = $(this).attr('data-filter');
    $images.isotope({ filter: selector });
    return false;
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);

//END
