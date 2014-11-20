$(document).ready(function() {
  $(".drop-hike").hide();

  $(".about").hover(function() { 
    $(".drop-hike").slideToggle();
  });

  $('.welcome-submit').on('click', function(e){
    e.preventDefault();
    debugger;
    alert("u dun submitted! lol");
    $('.hike-sign').animate({
      "margin-top": "50px"
    }, 10000, function(){
      alert('u dunn');
    });
    
    // $('.hike-sign').find($('h1')).animate({"font-size":"40px"});
  });

});