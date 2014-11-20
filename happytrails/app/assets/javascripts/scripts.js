$(document).ready(function() {
    $(".drop-hike").hide();


  $(".nav-bar").on("mouseenter", function() { 
    $(".drop-hike").slideToggle();
  });

});