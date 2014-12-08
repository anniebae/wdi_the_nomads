  ########### Yaniv Comment ###########
  # This looks like a job for....
  # tuh-duh-duh-duh.......!
  # Rake Tasks!

  # Incorporating this into a rake task would let us
  # load our code automatically... So there won't be
  # need to recreate the Trail model, or use
  # ActiveRecord::Base.establish_connection. It would
  # be done automatically for us.

  # Also, I see a lot of repeating code here. Someone
  # should come back to this file and extract all
  # of the repeating logic into methods. Maybe even a class!
  # Make it DRY! This file might only be run once... But that's
  # no reason to leave it unDRY or difficult to read (especially
  # if other people might need to run or modify it)


  # And last but not least,
  # LAST BUT NOT LEAST,
  # get the indentation right.
  # ASAP
  #####################################


require "active_record"

location_string = ""
location_set = []
trails_with_data = []
trail_coordinate_string_one=""
trail_coordinate_string_two=""
origin_set=""

# YOU CANNOT RUN THIS OFTEN #
grandcentral="40.752726,-73.977229"
# pennstation="40.75058,-73.99358"
# barclayscenter="40.68292,-73.975185"
# stanfordCT="41.0982343,-73.5653648"
# albanyNY="42.6681398,-73.8113997"

origin_set=grandcentral+"|"+pennstation+"|"+barclayscenter+"|"+stanfordCT+"|"+albanyNY

ActiveRecord::Base.establish_connection(
	adapter: 'postgresql',
	database: 'happytrails_development'
	)

class Trail <ActiveRecord::Base

def self.cleanthisshit
Trail.where(:lat<4).destroy_all
end

def self.callgoogleandsellyourhouse
trails_with_data = Trail.all

trails_with_data.each do |trail| 
	location_string<<trail["lat"].to_s+","+trail["lon"].to_s 
	trail[:geocoordinates] = location_string
	location_string=""
end

i = 0

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
cycling_request_one_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_one}&mode=bicycling&units=imperial")
cycling_request_two_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_two}&mode=bicycling&units=imperial")
walking_request_one_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_one}&mode=walking&units=imperial")
walking_request_two_grandcentral = URI.escape("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{grandcentral}&destinations=#{trail_coordinate_string_two}&mode=walking&units=imperial")

driving_response_one_grandcentral = HTTParty.get(driver_request_one_grandcentral)
sleep 12
driving_response_two_grandcentral = HTTParty.get(driver_request_two_grandcentral)
sleep 12
cycling_response_one_grandcentral = HTTParty.get(cycling_request_one_grandcentral)
sleep 12
cycling_response_two_grandcentral = HTTParty.get(cycling_request_two_grandcentral)
sleep 12
walking_response_one_grandcentral = HTTParty.get(walking_request_one_grandcentral)
sleep 12
walking_response_two_grandcentral = HTTParty.get(walking_request_two_grandcentral)

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

i=0
cycling_response_one_grandcentral["rows"][0]["elements"].each do |track| 
	trails_with_data[i][:cyclingfromgrandcentralseconds] = track["duration"]["value"]
	trails_with_data[i][:cyclingfromgrandcentralmiles] = track["distance"]["value"]
	i=i+1
end

cycling_response_two_grandcentral["rows"][0]["elements"].each do |track| 
	trails_with_data[i][:cyclingfromgrandcentralseconds] = track["duration"]["value"]
	trails_with_data[i][:cyclingfromgrandcentralmiles] = track["distance"]["value"]
	i=i+1
end

i=0
walking_response_one_grandcentral["rows"][0]["elements"].each do |track| 
	trails_with_data[i][:walkingfromgrandcentralseconds] = track["duration"]["value"]
	trails_with_data[i][:walkingfromgrandcentralmiles] = track["distance"]["value"]
	i=i+1
end

walking_response_two_grandcentral["rows"][0]["elements"].each do |track| 
	trails_with_data[i][:walkingfromgrandcentralseconds] = track["duration"]["value"]
	trails_with_data[i][:walkingfromgrandcentralmiles] = track["distance"]["value"]
	i=i+1
end

