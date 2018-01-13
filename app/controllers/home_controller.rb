class HomeController < ApplicationController
  def index
    @recipes = Recipe.recent(6)
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
end