$(document).ready(function() {
  $(".drop-hike").hide();

  $(".about").hover(function() { 
    $(".drop-hike").slideToggle();
  });

  $('.welcome-submit').on('click', function(e){
    e.preventDefault();
    $('.enter-location').css({"display":"none"});
    $('.hike-sign').animate({
      "margin-top": "50px"
    }, 600);
    $('.hike-sign').find($('h1')).animate({
      "font-size": "35px"
    }, 600);
    $('.container').animate({
      "width": "80%", "height": "7em", "margin-bottom": "20px"
    }, 600);
    $('.hike-sign').find($('h1')).animate({
      "font-size": "35px"
    }, 600);
    $('.form-p').animate({
      "width": "20%", "top": "-16%"
    });
    $('#address').animate({
      "left": "2%"
    });
    $('#city').animate({
      "left": "27%"
    });
    $('#state').animate({
      "left": "52%"
    });
    $('#zip').animate({
      "left": "77%"
    });
    $(this).animate({"top":"45%"});

  });


});