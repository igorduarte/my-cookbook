class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :recipes
  has_many :favorite_recipes, through: :favorites, source: :recipe

  def favorited?(recipe)
    favorite_recipes.include? recipe
  end

  def author?(recipe)
    self.eql? recipe.user
  end
end