class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipe = Recipe.find(params[:id])
    @recipes = Recipe.all
    @favorites = Favorite.all
    @user = current_user

    @recipes.where(user_id: @user.id, recipe_id: @recipe.id)
  end
end