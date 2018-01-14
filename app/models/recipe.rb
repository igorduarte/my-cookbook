class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  # belongs_to :author, class_name: "User", foreign_key: "author_id", optional: true
  belongs_to :user

  validates :title, :difficulty, :cook_time, :ingredients, :method,
    presence: { message: "Você deve informar todos os dados da receita" }

  # scope :recent, order(created_at: :desc).limit(6)
  scope :recent, ->(n) { order(created_at: :desc).limit(n) }


end