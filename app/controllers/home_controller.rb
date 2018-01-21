class HomeController < ApplicationController
  def index
    @recipes = Recipe.last(6)
    @favorited_recipes = Recipe.most_favorited(3)
  end
end