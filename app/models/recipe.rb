class Recipe < ApplicationRecord
  # belongs_to :author, class_name: "User", foreign_key: "author_id", optional: true
  # scope :recent, order(created_at: :desc).limit(6)
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user, optional: true

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  validates :title, :difficulty, :cook_time, :ingredients, :method,
    presence: { message: "Você deve informar todos os dados da receita" }

  scope :recent, ->(n) { order(created_at: :desc).limit(n) }
  scope :favorited_by, -> (username) { joins(:favorites).where(favorites: { user: User.where(name: username) }) }
  
end