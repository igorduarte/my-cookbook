class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.create(recipe_params)
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path
  end

  def search
    @search_term = params[:term]
    search_term_query = "%#{@search_term}%"
    @recipes = Recipe.where("title LIKE ? OR ingredients LIKE ?", search_term_query, search_term_query)
    flash[:error] = "Nenhuma receita encontrada com o termo #{@search_term}" unless @recipes.any?
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
      :difficulty, :cook_time, :ingredients, :method)
  end
end