class CuisinesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = Recipe.where(cuisine_id: params[:id])
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.create(cuisine_params)
    if @cuisine.save
      redirect_to @cuisine
    else
      flash.now[:error] = "Você deve informar o nome da cozinha"
      render 'new'
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name, :cuisine_id)
  end
end