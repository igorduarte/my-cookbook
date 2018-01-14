require 'rails_helper'

feature 'Recipe has author' do
  scenario 'shows the author of recipe' do
    user = create :user
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine, user: user

    login_as user, scope: :user

    visit root_path
    click_link recipe.title
    visit recipe_path(recipe)

    expect(page).to have_content "Autor: #{recipe.user.name}"
  end
end