$(document).ready(function() {
  $(".drop-hike").hide();

  $(".about").hover(function() { 
    $(".drop-hike").slideToggle();
  });

  $('.welcome-submit').on('click', function(e){
    alert("u dun submitted! lol");
  });

});