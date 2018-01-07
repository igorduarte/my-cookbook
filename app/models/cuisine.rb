class Cuisine < ApplicationRecord
  has_many :recipes
  validates :name, presence: { message: "Você deve informar o nome da cozinha" },
    uniqueness: { case_sensitive: false }
end