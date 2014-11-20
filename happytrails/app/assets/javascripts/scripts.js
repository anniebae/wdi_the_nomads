$(document).ready(function() {
  $(".drop-hike").hide();
  $(".drop-hello").hide();

  $(".about").hover(function() { 
    $(".drop-hike").slideToggle();
  });

  $(".hello").hover(function(){
  	$(".drop-hello").slideToggle();
  });

  $('.welcome-submit').on('click', function(e){
    e.preventDefault();
    $('.hike-sign').animate({
      "margin-top": "50px"
    }, 600);
    $('.hike-sign').find($('h1')).animate({
      "font-size": "35px"
    }, 600);


    $('.container').animate({
    	"width": "10%",
    });

    $ ('.container').find($('input')).animate({
    	"font-size": "12px",
    	"width": "30%"
    })


  });

});