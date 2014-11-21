function animateTitle(title, speed){
  
  $(title).animate({
    "margin-top": "50px"
  }, speed);

  $(title).find($('h1')).animate({
    "font-size": "35px"
  }, speed);
}

function animateLocationForm(form, speed){
  $(form).closest('.container').animate({
    "width": "80%", "height": "7em", "margin-bottom": "20px"
  }, speed);
  $(form).find('.welcome-submit').animate({
    "top":"45%","width":"10%","left":"45%"
  }, speed);
  $(form).find('.form-p').animate({
    "width": "20%", "top": "-16%"
  }, speed);
  $(form).find('.form-p#address').animate({
    "left": "2%"
  }, speed);
  $(form).find('.form-p#city').animate({
    "left": "27%"
  }, speed);
  $(form).find('.form-p#state').animate({
    "left": "52%"
  }, speed);
  $(form).find('.form-p#zip').animate({
    "left": "77%"
  }, speed);  
}


function secondsToHours(seconds){
  var hours = Math.floor(seconds/3600);
  var minutes = Math.floor((seconds%3600)/60);
  return hours + " hrs " + minutes + " minutes away"
}

function displayTrails(trails){
  var $trails = $(".altrowstable");
  $trails.empty();
  $(trails).each(function(index, trail){
    var trailHTML = trailToHTML(trail);
    $trails.append(trailHTML);
  });
  $trails.show();
}

function trailToHTML(trail){
  $tr = $("<tr>");
  $tr.addClass("trail");

  $tdTravelDist = $("<td>");
  $tdTravelDist.addClass("travel_distance");
  $tdTravelDist.text(secondsToHours(trail.drivingfromgrandcentralseconds));
  $tdTitle = $("<td>");
  $tdTitle.addClass("title");
  $tdTitle.text(trail.title);
  $tdTrailLength = $("<td>");
  $tdTrailLength.addClass("trail_length");
  $tdTrailLength.text(trail.length);
  $tdTrailDifficulty = $("<td>");
  $tdTrailDifficulty.addClass("trail_difficulty");
  $tdTrailDifficulty.text(trail.difficulty);

  $tr.append($tdTravelDist);
  $tr.append($tdTitle);
  $tr.append($tdTrailLength);
  $tr.append($tdTrailDifficulty);

  return $tr;
}

$(document).ready(function() {

  $(".drop-hike").hide();
  $(".drop-hello").hide();
  
  $(".about").hover(function() { 
    $(".drop-hike").slideToggle();
  });

  $(".hello").hover(function(){
    $(".drop-hello").slideToggle();
  });


  $('.location-form').on('submit', function(e){
    e.preventDefault();
    var speed = 400;
    $(this).siblings('h2').css({"display":"none"});
    var title = $(this).parents('.center').find('.hike-sign');
    animateTitle(title, speed);
    animateLocationForm(this, speed);


    var $form = $(this);
    var address = $(e.target).find('#address-submit').val();
    var city = $(e.target).find('#city-submit').val();
    var state = $(e.target).find('#state-submit').val();
    var zip = $(e.target).find('#zip-submit').val();

    $.ajax({
      url: '/trails',
      method: 'GET',
      dataType: 'JSON',
      data: {
        address: address,
        city: city,
        state: state,
        zip: zip,
      },
      success: function(data){
        var trails = data.trails;
        displayTrails(trails);
      }
    });
  });
});

