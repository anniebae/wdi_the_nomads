class TrailsolutionsController < ApplicationController

  def index
    binding.pry
  end

  def show
    @trailsolution = Trailsolution.all.sample
  end

end
