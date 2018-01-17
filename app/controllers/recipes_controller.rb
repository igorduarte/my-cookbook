class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

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

    # redirect_to root_path unless @recipe.user == current_user
    redirect_to_home_if_not_author
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
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

  def favorite
    @recipe = Recipe.find(params[:id])
    # @favorite = Favorite.create(user: current_user, recipe: @recipe)
    @favorite = current_user.favorites.create(recipe: @recipe)

    if @favorite.valid?
      flash[:notice] = 'Receita adicionada aos favoritos'
      redirect_to recipe_path(@recipe)
    end
  end

  def unfavorite
    @recipe = Recipe.find(params[:id])
    @favorite = Favorite.find_by(user: current_user, recipe: @recipe)

    @favorite.destroy
    flash[:notice] = 'Receita removida dos favoritos'
    redirect_to recipe_path(@recipe)
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :difficulty, :cook_time,
      :ingredients, :method, :favorite, :recipe_type_id, :cuisine_id, :user_id)
  end

  def redirect_to_home_if_not_author
   @recipe = Recipe.find(params[:id])
   redirect_to root_path unless @recipe.user == current_user
  end
end