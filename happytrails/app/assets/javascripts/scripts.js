$(document).ready(function() {
  $(".drop-hike").hide();

  $(".about").hover(function() { 
    $(".drop-hike").slideToggle();
  });

  $('.welcome-submit').on('click', function(e){
    e.preventDefault();
    $('.hike-sign').animate({
      "margin-top": "50px"
    }, 600);
    $('.hike-sign').find($('h1')).animate({
      "font-size": "35px"
    }, 600);    
  });

});