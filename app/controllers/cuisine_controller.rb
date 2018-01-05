class CuisineController < ApplicationController
  def show
    @cuisines = Cuisine.all
  end
end