class TrailsolutionsController < ApplicationController
  def index
  end

  def show
    @trailsolution = Trailsolution.all.sample
  end

end
