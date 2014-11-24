class DirectionsController < ApplicationController

  def show
    startpoint_address = params[:startpoint_address]
    trail = Trail.find(params[:id])
    target_coordinates = trail.lat + "," + trail.lon
    directions = trail.getdirections(startpoint_address, target_coordinates)
    respond_to do |format|
      format.html
      format.json {render :json => {directions: directions}}
    end
  end

end
