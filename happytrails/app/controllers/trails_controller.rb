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
    paragraphs = paragraphs.to_a
    paragraphs.reject! { |p| p.body=="&nbsp;" || p.body[0..6]=='style="' || p.body == ".]" }
    date_of_hike = []
    paragraphs.each_with_index do |p,i|
      if p.body[0..11] == "Date of hike"
        date_of_hike.push(i)
      end
    end
    if date_of_hike != []
      paragraphs = paragraphs[0...date_of_hike[0]]
    end
    paragraphs.each do |p|
      p.body.gsub!(/<[^>]+>/, "")
      p.body.gsub!(/^[^>]+>\s/, "")
      p.body.gsub!(">", "")
      p.body.gsub!("&nbsp;", "")
    end
    respond_to do |format|
      format.html
      format.json {render :json => {paragraphs: paragraphs}}
    end
  end

end
