require 'rails_helper'

feature 'User manages his recipes' do
  scenario 'only logged users sees edit button' do
    user = create :user
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine, user: user

    logout user

    visit root_path
    click_link recipe.title
    visit recipe_path(recipe)

    expect(page).not_to have_content "Editar"
  end

  scenario 'and are redirected to homepage if accesss edit_path via URI' do
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    billy = create :user, name: 'Billy'
    sally = create :user, name: 'Sally'
    billy_recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine, user: billy
    sally_recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine, user: sally

    login_as billy

    visit edit_recipe_path(sally_recipe)

    expect(current_path).to eq root_path
  end

  scenario 'not see edit button if it\'is not the owner of recipe' do
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    billy = create :user, name: 'Billy'
    sally = create :user, name: 'Sally'

    sally_recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine, user: sally

    login_as billy

    visit root_path
    click_link sally_recipe.title

    expect(page).not_to have_link 'Editar'
  end
end