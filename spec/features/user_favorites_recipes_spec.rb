require 'rails_helper'

feature 'User favorites recipes' do
  scenario 'click on favorite button' do
    user = create :user
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine, user: user

    login_as user, scope: :user

    visit root_path
    click_link recipe.title

    expect(page).to have_content('Favoritar Receita')
  end
#   pending
#   scenario 'and see favorited recipe in favorites path' do
#     user = create :user
#     cuisine = create :cuisine
#     recipe_type = create :recipe_type
#     recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine, user: user
#
#     login_as user
#
#     visit root_path
#     click_link recipe.title
#     click_on 'Favoritar Receita'
#
#     expect(favorite_recipes_path).to have_content(recipe.title)
#   end
end