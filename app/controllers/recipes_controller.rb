class RecipesController < ApplicationController
  before_action :authenticate_user!,
    only: [:new, :create, :edit, :update, :destroy]
  before_action :set_recipe,
    only: [:show, :edit, :update, :destroy, :favorite, :unfavorite, :share]

  def index
    @recipes ||= Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    unless current_user.author?(@recipe)
      flash[:notice] = 'Você não tem permissão para editar essa receita'
      redirect_to root_path
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      set_cuisines
      set_types
      render 'new'
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      set_cuisines
      set_types
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    flash[:notice] = 'Receita excluída'
    redirect_to root_path
  end

  def search
    @search_term = params[:term]
    search_term_query = "%#{@search_term}%"
    @recipes = Recipe.where("title LIKE ? OR ingredients LIKE ?",
      search_term_query, search_term_query)
      
    unless @recipes.any?
      flash[:error] = "Nenhuma receita encontrada com o termo #{@search_term}"
    end
  end

  def favorite
    @favorite = current_user.favorites.create(recipe: @recipe)
    if @favorite.valid?
      flash[:notice] = 'Receita adicionada aos favoritos'
      redirect_to recipe_path(@recipe)
    end
  end

  def unfavorite
    @favorite = Favorite.find_by(user: current_user, recipe: @recipe)
    @favorite.destroy
    flash[:notice] = 'Receita removida dos favoritos'
    redirect_to recipe_path(@recipe)
  end

  def share
    @email = params[:email]
    @message = params[:message]

    RecipesMailer.share(@email, @message, @recipe.id).deliver_now

    flash[:notice] = "Receita enviada para #{@email}"
    redirect_to @recipe
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :difficulty, :cook_time,
      :ingredients, :method, :recipe_type_id, :cuisine_id, :user_id,
      :image, :star)
  end

  def set_recipe
    @recipe ||= Recipe.find(params[:id])
  end
end