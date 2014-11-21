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

# =========================================================================================================
#                      THIS WILL CLEAR YOUR DATABASE OF UNUSABLE TRAILS
# =========================================================================================================

def self.sweeptrails
Trail.where(:lat<4).destroy_all
end

# =========================================================================================================
#                       THIS WILL LOAD GEO-COORDINATES INTO YOUR TABLE
# =========================================================================================================

def self.setgeocoordinates
  Trail.all.each do |trail| 
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
#                           THIS WILL RING GOOGLE AND LOAD DISTANCE DATA TO GC NYC
#                            DO NOT DO THIS MORE THAN ONCE PER IP ADDRESS PER DAY
#                             OR DON'T BE A PLEB, AND PAY GOOGLE FOR THEIR WORK
#                                              $$$ AMERICA $$$
# =========================================================================================================


def self.stagenewyork
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

  trails_with_data.each do {|trail| trail.save}

end

# =========================================================================================================
#                       THIS WILL CONTACT GOOGLE FOR DIRECTION TO A TRAIL
# =========================================================================================================

	 
  def self.getdistances(startpoint_address, transit_type, set_of_trail_head_addresses, launch_time, time_type)
  	
  	# First, I am going to make a string for the API request. It needs to be under 2000 characters long.

  	if transit_type == "mass transit"
	  		mode = "transit"
	  	elsif transit_type == "bicycling"
	  		mode = "bicycling"
	  	elsif transit_type == "walking"
	  		mode = "walking"
	  	else
	  		mode = "driving"
  	end

    #Replace spaces with + signs
  	origin = startpoint_address.gsub(/\s/,"+")

    #Convert times to epoch
    time = DateTime.parse(launch_time).to_time.to_i

    # figure out whether you are dealing with a start time or an end time
    if time_type == "departs at"
      time_target = "departure_time="
    else
      time_target = "arrival_time="
    end

    time_packet = time_target.to_s+time.to_s

    # The addresses then need to be strung together as follows: latitude,longitude|latitude,longitude
    destination_string = ""
  	destination_list = []

    set_of_trail_head_addresses.each do |trail|
  		latitude = trail[:latitude]
  		longitude = trail[:longitude]
  		destination = latitude.to_s+","+longitude.to_s
      destination_list<<destination
    end

    destination_list.each{|destination| destination_string<<destination.to_s+"|"}

  		packet = "origin=#{origin}&#{time_packet}&mode=#{mode}&destination=#{destinationset}"

  	addresspackets < packet
  	
  	response = HTTParty.get("https://maps.googleapis.com/maps/api/distancematrix/json? #{addresspackets}")  	

 	response.to_json
  end

end
