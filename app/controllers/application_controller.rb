class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_types, only: [:index, :show, :new, :edit, :create, :search]
  before_action :set_cuisines, only: [:index, :show, :new, :edit, :create, :search]

  private

  def set_cuisines
    @cuisines ||= Cuisine.all
  end

  def set_types
    @recipe_types ||= RecipeType.all
  end
end
