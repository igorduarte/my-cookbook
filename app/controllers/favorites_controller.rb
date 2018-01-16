class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.all
    @favorites = Favorite.all
    @user = current_user

    @recipes.where(user_id: @user, recipe_id: @recipe)
  end
end