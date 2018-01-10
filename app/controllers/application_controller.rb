class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def list_all
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    @recipes = Recipe.all
  end
end
