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
  var trail = trail;
  var $tr = $("<tr>");
  $tr.addClass("trail");

  var $tdTravelDist = $("<td>");
  $tdTravelDist.addClass("travel_distance");
  $tdTravelDist.text(secondsToHours(trail.drivingfromgrandcentralseconds));

  var $tdTitle = $("<td>");
  $tdTitle.addClass("title");
  var $a = $("<a>");
  $a.addClass("title-link");
  $a.text(trail.title);
  $a.attr("href", trail.url);

  $a.on('click', function(e){
    e.preventDefault();
    displayTrailInfoBox(trail);

  })

  $tdTitle.append($a);
  var $tdTrailLength = $("<td>");
  $tdTrailLength.addClass("trail_length");
  $tdTrailLength.text(trail.length);
  var $tdTrailDifficulty = $("<td>");
  $tdTrailDifficulty.addClass("trail_difficulty");
  $tdTrailDifficulty.text(trail.difficulty);

  $tr.append($tdTravelDist);
  $tr.append($tdTitle);
  $tr.append($tdTrailLength);
  $tr.append($tdTrailDifficulty);

  return $tr;
}

function displayTrailInfoBox(trail){
  var $trailDetails = $('.trail-details');
  $trailDetails.empty();
  var trailHTMLDetails = trailToDetails(trail);
  $trailDetails.append(trailHTMLDetails);
  $trailDetails.parent().show().css("opacity", 1).slideDown(1000);
}

function trailToDetails(trail){
  var $div = $('<div>');

  var $h3Title = $('<h3>');
  $h3Title.addClass('infobox-title');
  $h3Title.text(trail.title);

  var $img = $('<img>');
  $img.addClass('infobox-img');
  $img.attr({src: trail.img});

  var $pAddress = $('<p>');
  $pAddress.addClass('infobox-address');
  $pAddress.text(trail.region + ', ' + trail.state);

  var $pDuration = $('<p>');
  var $spanDuration = $('<span>');
  $pDuration.addClass('infobox-duration');
  $spanDuration.addClass('infobox-header');
  $pDuration.text(trail.length);
  $spanDuration.text('DURATION: ')
  $pDuration.prepend($spanDuration);

  var $pDifficulty = $('<p>');
  var $spanDifficulty = $('<span>');
  $pDifficulty.addClass('infobox-difficulty');
  $spanDifficulty.addClass('infobox-header');
  $pDifficulty.text(trail.difficulty);
  $spanDifficulty.text('DIFFICULTY: ')
  $pDifficulty.prepend($spanDifficulty);

  var id = trail.id;
  var $description = $('<div>');
  $.ajax({
    url: '/trails/' + id,
    method: 'GET',
    dataType: 'json',
    data: {trail_id: id},
    success: function(data){
      var paragraphs = data.paragraphs;
      $description.addClass('infobox-description');
      $.each(paragraphs, function(idx, pgraph){
        var $p = $('<p>');
        $p.text(pgraph.body);
        $description.append($p);
      });
    }
  });
                 
  $div.append($h3Title);
  $div.append($img);
  $div.append($pAddress);
  $div.append($pDuration);
  $div.append($pDifficulty);
  $div.append($description);

  return $div;
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


// ************************* TROUBLE ************************
 
  $('.close_box').on('click', function(){
    $(this).parent().fadeTo(300,0,function(){
      $(this).hide();
    });
  });

// ************************* TROUBLE ************************


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


