
// Ready & Page:Load Function

var ready;
ready = function() {

  // FancyBox
  $("a.fancybox").fancybox({
    padding: 0,
    helpers: {
      overlay: {
        locked: false
      }
    }
  });

  // Isotope
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