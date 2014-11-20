class Trailsolution < ActiveRecord::Base
  
  def self.getdistances(startpoint_address, transit_type, set_of_trail_head_addresses, departure_time)
  	
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

  	origin = startpoint_address.gsub(/\s/,"+")
  	
  	# You need to regex the address strings to have + between words

  	set_of_trail_head_addresses.each do |trail|
  		latitude = trail[:latitude]
  		longitude = trail[:longitude]
  		destination = latitude+longitude
  	end


  		packet = "origin=#{origin}&destination=#{destination}&mode=#{mode}&#{}"

  	addresspackets < packet
  	
  	response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?#{addresspackets}")  	

 	response.to_json
  end


end