require 'rails_helper'

feature 'User delete recipe' do
  scenario 'succesfully' do
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine

    user = create :user
    login_as user, scope: :user

    visit root_path
    click_link recipe.title
    visit recipe_path(recipe)
    click_on "Excluir Receita"

    expect(Recipe.all).not_to include recipe
    expect(current_path).to eq root_path
    # expect(recipe.destroyed?).to be true
  end
end