class Trailsolution < ActiveRecord::Base
  
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