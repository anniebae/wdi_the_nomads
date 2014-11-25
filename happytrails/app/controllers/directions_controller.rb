class DirectionsController < ApplicationController


  def getdirections(startpoint_address, target_coordinates)

    origin = startpoint_address.gsub(/\s/,"+")

    packet = "origin=#{origin}&destination=#{target_coordinates}&units=imperial"

    response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?#{packet}")

    directions = response["routes"][0]["legs"][0]["steps"]

    [["5 miles", "feklw", "fejkw"], ["fjklew"]]

  end

  def index
    startpoint_address = params[:startpoint_address]
    trail = Trail.find(params[:trail_id])
    target_coordinates = trail.lat.to_s + "," + trail.lon.to_s
    directions = getdirections(startpoint_address, target_coordinates)
    respond_to do |format|
      format.html
      format.json {render :json => {directions: directions}}
    end
  end

end
