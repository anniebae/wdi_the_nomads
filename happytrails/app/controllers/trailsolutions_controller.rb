class TrailsolutionsController < ApplicationController
  def index
  	session[:transit_method] = transit_method
  	session[:current_address] = current_address
  end
end
