class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.create(recipe_params)
    redirect_to @recipe
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type, :cuisine_id, :difficulty,
      :cook_time, :ingredients, :method)
  end
end
