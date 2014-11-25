# =========================================================================================================
#
#   ~~~888~~~ 888~-_        e      888 888                e    e        ,88~-_   888~-_   888~~  888
#      888    888   \      d8b     888 888               d8b  d8b      d888   \  888   \  888___ 888
#      888    888    |    /Y88b    888 888              d888bdY88b    88888    | 888    | 888    888
#      888    888   /    /  Y88b   888 888             / Y88Y Y888b   88888    | 888    | 888    888
#      888    888_-~    /____Y88b  888 888            /   YY   Y888b   Y888   /  888   /  888    888
#      888    888 ~-_  /      Y88b 888 888____       /          Y888b   `88_-~   888_-~   888___ 888____
#
# =========================================================================================================


class Trail <ActiveRecord::Base
require 'HTTParty'
has_many :paragraphs
# =========================================================================================================
#                      THIS WILL CLEAR YOUR DATABASE OF UNUSABLE TRAILS
# =========================================================================================================

def self.sweeptrails
Trail.where("lat<4.0").destroy_all
end

# =========================================================================================================
#                       THIS WILL LOAD GEO-COORDINATES INTO YOUR TABLE
# =========================================================================================================

def self.setgeocoordinates
  Trail.all.each do |trail|
    location_string = ""
    location_string<<trail["lat"].to_s+","+trail["lon"].to_s
    trail[:geocoordinates] = location_string
    location_string=""
    trail.save
  end
end


# =========================================================================================================
#                                                    $$$$
#                                               $  $      $  $
#                                              $|$$        $$|$
#                                               $ $  $   $ $ $
#                                                  $   $   $
#                                                $  $  _  $   $
#                                               $$   $  $ $   $$
#                                              $$$$ $$  $  $$$$$$
#
#                   :::====  :::==== :::==== :::===== :::= === :::==== ::: :::====  :::= ===
#                   :::  === :::==== :::==== :::      :::===== :::==== ::: :::  === :::=====
#                   ========   ===     ===   ======   ========   ===   === ===  === ========
#                   ===  ===   ===     ===   ===      === ====   ===   === ===  === === ====
#                   ===  ===   ===     ===   ======== ===  ===   ===   ===  ======  ===  ===
#
#                             THESE WILL RING GOOGLE AND LOAD STATIC DISTANCE DATA
#                            DO NOT DO THIS MORE THAN ONCE PER IP ADDRESS PER DAY
#                             OR DON'T BE A PLEB, AND PAY GOOGLE FOR THEIR WORK
# 
# =========================================================================================================


def self.stagegrandcentral
  location_string = ""
  location_set = []
  trails_with_data = []
  trail_coordinate_string_one=""
  trail_coordinate_string_two=""
  origin_set=""

  grandcentral="40.752726,-73.977229"
  # pennstation="40.75058,-73.99358"
  # barclayscenter="40.68292,-73.975185"
  # stanfordCT="41.0982343,-73.5653648"
  # albanyNY="42.6681398,-73.8113997"
  trails_with_data=Trail.all
  i = 0

# THIS IS NECESSARY DUE TO THE 2K CHAR LIMITATION ON URLS
  85.times do |i|
    trail_coordinate_string_one<<trails_with_data[i][:geocoordinates]+"|"
    i = i+1
  end

  i = 85

  85.times do |i|
    trail_coordinate_string_two<<trails_with_data[i][:geocoordinates]+"|"
    i = i+1
  end

  trail_coordinate_string_one=trail_coordinate_string_one.chop
  trail_coordinate_string_two=trail_coordinate_string_two.chop

  driver_request_one_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_one}&units=imperial")
  driver_request_two_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_two}&units=imperial")
  # cycling_request_one_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_one}&mode=bicycling&units=imperial")
  # cycling_request_two_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_two}&mode=bicycling&units=imperial")
  # walking_request_one_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_one}&mode=walking&units=imperial")
  # walking_request_two_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_two}&mode=walking&units=imperial")

  driving_response_one_grandcentral = HTTParty.get(driver_request_one_grandcentral)
  sleep 12
  driving_response_two_grandcentral = HTTParty.get(driver_request_two_grandcentral)
  sleep 12
  # cycling_response_one_grandcentral = HTTParty.get(cycling_request_one_grandcentral)
  # sleep 12
  # cycling_response_two_grandcentral = HTTParty.get(cycling_request_two_grandcentral)
  # sleep 12
  # walking_response_one_grandcentral = HTTParty.get(walking_request_one_grandcentral)
  # sleep 12
  # walking_response_two_grandcentral = HTTParty.get(walking_request_two_grandcentral)

  i=0
  driving_response_one_grandcentral["rows"][0]["elements"].each do |track|
    trails_with_data[i][:drivingfromgrandcentralseconds] = track["duration"]["value"]
    trails_with_data[i][:drivingfromgrandcentralmiles] = track["distance"]["value"]
    i=i+1
  end

  driving_response_two_grandcentral["rows"][0]["elements"].each do |track|
    trails_with_data[i][:drivingfromgrandcentralseconds] = track["duration"]["value"]
    trails_with_data[i][:drivingfromgrandcentralmiles] = track["distance"]["value"]
    i=i+1
  end

  # i=0
  # cycling_response_one_grandcentral["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:cyclingfromgrandcentralseconds] = track["duration"]["value"]
  #   trails_with_data[i][:cyclingfromgrandcentralmiles] = track["distance"]["value"]
  #   i=i+1
  # end

  # cycling_response_two_grandcentral["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:cyclingfromgrandcentralseconds] = track["duration"]["value"]
  #   trails_with_data[i][:cyclingfromgrandcentralmiles] = track["distance"]["value"]
  #   i=i+1
  # end

  # i=0
  # walking_response_one_grandcentral["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:walkingfromgrandcentralseconds] = track["duration"]["value"]
  #   trails_with_data[i][:walkingfromgrandcentralmiles] = track["distance"]["value"]
  #   i=i+1
  # end

  # walking_response_two_grandcentral["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:walkingfromgrandcentralseconds] = track["duration"]["value"]
  #   trails_with_data[i][:walkingfromgrandcentralmiles] = track["distance"]["value"]
  #   i=i+1
  # end

  trails_with_data.each do |trail|
    trail.save
  end

end


def self.stagebarclayscenter
  location_string = ""
  location_set = []
  trails_with_data = []
  trail_coordinate_string_one=""
  trail_coordinate_string_two=""
  origin_set=""

  # grandcentral="40.752726,-73.977229"
  # pennstation="40.75058,-73.99358"
  barclayscenter="40.68292,-73.975185"
  # stanfordCT="41.0982343,-73.5653648"
  # albanyNY="42.6681398,-73.8113997"
  trails_with_data=Trail.all
  i = 0

# THIS IS NECESSARY DUE TO THE 2K CHAR LIMITATION ON URLS
  85.times do |i|
    trail_coordinate_string_one<<trails_with_data[i][:geocoordinates]+"|"
    i = i+1
  end

  i = 85

  85.times do |i|
    trail_coordinate_string_two<<trails_with_data[i][:geocoordinates]+"|"
    i = i+1
  end

  trail_coordinate_string_one=trail_coordinate_string_one.chop
  trail_coordinate_string_two=trail_coordinate_string_two.chop

  driver_request_one_barclayscenter = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{barclayscenter}&destinations=#{trail_coordinate_string_one}&units=imperial")
  driver_request_two_barclayscenter = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{barclayscenter}&destinations=#{trail_coordinate_string_two}&units=imperial")
  # cycling_request_one_barclayscenter = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{barclayscenter}&destinations=#{trail_coordinate_string_one}&mode=bicycling&units=imperial")
  # cycling_request_two_barclayscenter = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{barclayscenter}&destinations=#{trail_coordinate_string_two}&mode=bicycling&units=imperial")
  # walking_request_one_barclayscenter = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{barclayscenter}&destinations=#{trail_coordinate_string_one}&mode=walking&units=imperial")
  # walking_request_two_barclayscenter = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{barclayscenter}&destinations=#{trail_coordinate_string_two}&mode=walking&units=imperial")

  driving_response_one_barclayscenter = HTTParty.get(driver_request_one_barclayscenter)
  sleep 12
  driving_response_two_barclayscenter = HTTParty.get(driver_request_two_barclayscenter)
  sleep 12
  # cycling_response_one_barclayscenter = HTTParty.get(cycling_request_one_barclayscenter)
  # sleep 12
  # cycling_response_two_barclayscenter = HTTParty.get(cycling_request_two_barclayscenter)
  # sleep 12
  # walking_response_one_barclayscenter = HTTParty.get(walking_request_one_barclayscenter)
  # sleep 12
  # walking_response_two_barclayscenter = HTTParty.get(walking_request_two_barclayscenter)

  i=0
  driving_response_one_barclayscenter["rows"][0]["elements"].each do |track|
    trails_with_data[i][:drivingfrombarclayscenterseconds] = track["duration"]["value"]
    trails_with_data[i][:drivingfrombarclayscentermiles] = track["distance"]["value"]
    i=i+1
  end

  driving_response_two_barclayscenter["rows"][0]["elements"].each do |track|
    trails_with_data[i][:drivingfrombarclayscenterseconds] = track["duration"]["value"]
    trails_with_data[i][:drivingfrombarclayscentermiles] = track["distance"]["value"]
    i=i+1
  end

  # i=0
  # cycling_response_one_barclayscenter["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:cyclingfrombarclayscenterseconds] = track["duration"]["value"]
  #   trails_with_data[i][:cyclingfrombarclayscentermiles] = track["distance"]["value"]
  #   i=i+1
  # end

  # cycling_response_two_barclayscenter["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:cyclingfrombarclayscenterseconds] = track["duration"]["value"]
  #   trails_with_data[i][:cyclingfrombarclayscentermiles] = track["distance"]["value"]
  #   i=i+1
  # end

  # i=0
  # walking_response_one_barclayscenter["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:walkingfrombarclayscenterseconds] = track["duration"]["value"]
  #   trails_with_data[i][:walkingfrombarclayscentermiles] = track["distance"]["value"]
  #   i=i+1
  # end

  # walking_response_two_barclayscenter["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:walkingfrombarclayscenterseconds] = track["duration"]["value"]
  #   trails_with_data[i][:walkingfrombarclayscentermiles] = track["distance"]["value"]
  #   i=i+1
  # end

  trails_with_data.each do |trail|
    trail.save
  end

end

def self.stagealbanyny
  location_string = ""
  location_set = []
  trails_with_data = []
  trail_coordinate_string_one=""
  trail_coordinate_string_two=""
  origin_set=""

  # grandcentral="40.752726,-73.977229"
  # pennstation="40.75058,-73.99358"
  # barclayscenter="40.68292,-73.975185"
  # stamfordCT="41.0982343,-73.5653648"
  albanyNY="42.6681398,-73.8113997"
  trails_with_data=Trail.all
  i = 0

# THIS IS NECESSARY DUE TO THE 2K CHAR LIMITATION ON URLS
  85.times do |i|
    trail_coordinate_string_one<<trails_with_data[i][:geocoordinates]+"|"
    i = i+1
  end

  i = 85

  85.times do |i|
    trail_coordinate_string_two<<trails_with_data[i][:geocoordinates]+"|"
    i = i+1
  end

  trail_coordinate_string_one=trail_coordinate_string_one.chop
  trail_coordinate_string_two=trail_coordinate_string_two.chop

  driver_request_one_albanyNY = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{albanyNY}&destinations=#{trail_coordinate_string_one}&units=imperial")
  driver_request_two_albanyNY = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{albanyNY}&destinations=#{trail_coordinate_string_two}&units=imperial")
  # cycling_request_one_albanyNY = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{albanyNY}&destinations=#{trail_coordinate_string_one}&mode=bicycling&units=imperial")
  # cycling_request_two_albanyNY = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{albanyNY}&destinations=#{trail_coordinate_string_two}&mode=bicycling&units=imperial")
  # walking_request_one_albanyNY = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{albanyNY}&destinations=#{trail_coordinate_string_one}&mode=walking&units=imperial")
  # walking_request_two_albanyNY = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{albanyNY}&destinations=#{trail_coordinate_string_two}&mode=walking&units=imperial")

  driving_response_one_albanyNY = HTTParty.get(driver_request_one_albanyNY)
  sleep 12
  driving_response_two_albanyNY = HTTParty.get(driver_request_two_albanyNY)
  sleep 12
  # cycling_response_one_albanyNY = HTTParty.get(cycling_request_one_albanyNY)
  # sleep 12
  # cycling_response_two_albanyNY = HTTParty.get(cycling_request_two_albanyNY)
  # sleep 12
  # walking_response_one_albanyNY = HTTParty.get(walking_request_one_albanyNY)
  # sleep 12
  # walking_response_two_albanyNY = HTTParty.get(walking_request_two_albanyNY)

  i=0
  driving_response_one_albanyNY["rows"][0]["elements"].each do |track|
    trails_with_data[i][:drivingfromalbanyNYseconds] = track["duration"]["value"]
    trails_with_data[i][:drivingfromalbanyNYmiles] = track["distance"]["value"]
    i=i+1
  end

  driving_response_two_albanyNY["rows"][0]["elements"].each do |track|
    trails_with_data[i][:drivingfromalbanyNYseconds] = track["duration"]["value"]
    trails_with_data[i][:drivingfromalbanyNYmiles] = track["distance"]["value"]
    i=i+1
  end

  # i=0
  # cycling_response_one_albanyNY["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:cyclingfromalbanyNYseconds] = track["duration"]["value"]
  #   trails_with_data[i][:cyclingfromalbanyNYmiles] = track["distance"]["value"]
  #   i=i+1
  # end

  # cycling_response_two_albanyNY["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:cyclingfromalbanyNYseconds] = track["duration"]["value"]
  #   trails_with_data[i][:cyclingfromalbanyNYmiles] = track["distance"]["value"]
  #   i=i+1
  # end

  # i=0
  # walking_response_one_albanyNY["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:walkingfromalbanyNYseconds] = track["duration"]["value"]
  #   trails_with_data[i][:walkingfromalbanyNYmiles] = track["distance"]["value"]
  #   i=i+1
  # end

  # walking_response_two_albanyNY["rows"][0]["elements"].each do |track|
  #   trails_with_data[i][:walkingfromalbanyNYseconds] = track["duration"]["value"]
  #   trails_with_data[i][:walkingfromalbanyNYmiles] = track["distance"]["value"]
  #   i=i+1
  # end

  trails_with_data.each do |trail|
    trail.save
  end

end



# =========================================================================================================
#                  __________________   ____  ________  __________________________  _   _______
#                 / ____/ ____/_  __/  / __ \/  _/ __ \/ ____/ ____/_  __/  _/ __ \/ | / / ___/
#                / / __/ __/   / /    / / / // // /_/ / __/ / /     / /  / // / / /  |/ /\__ \
#               / /_/ / /___  / /    / /_/ // // _, _/ /___/ /___  / / _/ // /_/ / /|  /___/ /
#               \____/_____/ /_/    /_____/___/_/ |_/_____/\____/ /_/ /___/\____/_/ |_//____/
#
#                                         !WWWWWeeu..   ..ueeWWWWW!
#                                          "$$(    R$$e$$R    )$$"
#                                           "$8oeeo. "*" .oeeo8$"
#                                           .$$#"""*$i i$*"""#$$.
#                                           9$" @*c $$ $$F @*c $N
#                                           9$  NeP $$ $$L NeP $$
#                                           `$$uuuuo$$ $$uuuuu$$"
#                                           x$P**$$P*$"$P#$$$*R$L
#                                          x$$   #$k #$F :$P` '#$i
#                                          $$     #$  #  $$     #$k
#                                         d$"     '$L   x$F     '$$
#                                         $$      '$E   9$>      9$>
#                                         $6       $F   ?$>      9$>
#                                         $$      d$    '$&      8$
#                                         "$k    x$$     !$k    :$$
#                                          #$b  u$$L      9$b.  $$"
#                                          '#$od$#$$u....u$P$Nu@$"
#                                          ..?$R)..?R$$$$*"  #$P
#                                          $$$$$$$$$$$$$$@WWWW$NWWW
#                                          `````""3$F""""#$F"""""""
#                                                 @$.... '$B
#                                                d$$$$$$$$$$:
#                                                ````````````
# =========================================================================================================



end
