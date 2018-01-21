class AddStarToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :star, :boolean
  end
end
