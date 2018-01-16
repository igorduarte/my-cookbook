class RemoveFavoriteFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :favorite, :boolean
  end
end
