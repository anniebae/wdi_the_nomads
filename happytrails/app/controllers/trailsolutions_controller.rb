class TrailsolutionsController < ApplicationController

  def index
    address = params[:address] || ""
    city = params[:city] || ""
    state = params[:state] || ""
    zip = params[:zip] || ""
    @startpoint_address = address + " " + city + " " + state + " " + zip
    respond_to do |format|
      format.html
      format.json { render :json => {startpoint_address: @startpoint_address}}
    end
  end

  def show
    @trailsolution = Trailsolution.all.sample
  end

end

