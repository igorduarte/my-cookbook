require 'rails_helper'

feature 'User sees last recipes' do
  scenario 'shows only 6 recipes in homepage' do
    user = create :user
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create_list(:recipe, 10, cuisine: cuisine,
      recipe_type: recipe_type, user: user)

    login_as user

    visit root_path

    expect(page).to have_css 'div.col-md-12', count: 6
    expect(page).not_to have_css 'div.col-md-12', count: 10
  end

  scenario 'and click link to see all recipes' do
    user = create :user
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create_list(:recipe, 10, cuisine: cuisine,
      recipe_type: recipe_type, user: user)

    login_as user

    visit root_path
    click_link 'Ver todas as receitas'

    expect(current_path).to eq recipes_path
    expect(page).to have_css 'div.col-md-12', count: 10
    expect(page).not_to have_css 'div.col-md-12', count: 6
  end
end