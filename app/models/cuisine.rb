class Cuisine < ApplicationRecord
  has_many :recipes
  validates :name, presence: true,
    uniqueness: { case_sensitive: false, message: 'Cozinha já está em uso' }
end