class TrailsController < ApplicationController

  def index
    address = params[:address] || ""
    city = params[:city] || ""
    state = params[:state] || ""
    zip = params[:zip] || ""
    @startpoint_address = address + " " + city + "," + state + " " + zip

    target_solution = "drivingfrom"+Trail.findnearestneighbor(@startpoint_address)+"seconds"

    trails = Trail.order(target_solution).limit(10)
    respond_to do |format|
      format.html
      format.json { render :json => {trails: trails, startpoint_address: @startpoint_address, target_solution: target_solution}}
    end
  end

  def show
    trail = Trail.find(params[:id])
    paragraphs = trail.paragraphs.order('index')
    respond_to do |format|
      format.html
      format.json {render :json => {paragraphs: paragraphs}}
    end
  end

end
