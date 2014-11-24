class TrailsController < ApplicationController

  def index
    address = params[:address] || ""
    city = params[:city] || ""
    state = params[:state] || ""
    zip = params[:zip] || ""
    startpoint_address = address + " " + city + "," + state + " " + zip
    # @trails = Trail.search_by(startpoint_address)
    @trails = []
    10.times do |i|
      @trails.push(Trail.all.sample)
    end
    trails = @trails
    respond_to do |format|
      format.html
      format.json { render :json => {trails: trails, startpoint_address: startpoint_address}}
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
