class HomeController < ApplicationController
  def index
    @recipes = Recipe.last(6)
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    @favorited_recipes = Recipe.most_favorited(3)
  end
end