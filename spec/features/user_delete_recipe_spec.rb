require 'rails_helper'

feature 'User delete recipe' do
  scenario 'succesfully' do
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    user = create :user
    recipe = create :recipe, recipe_type: recipe_type,
      cuisine: cuisine, user: user
    another_recipe = create :recipe, title: 'Risoto', recipe_type: recipe_type,
      cuisine: cuisine, user: user

    login_as user

    visit root_path
    click_link recipe.title
    click_on 'Excluir Receita'

    expect(current_path).to eq root_path
    expect(Recipe.all).not_to include recipe
    expect(page).to have_content 'Receita excluída'
    expect(page).not_to have_link recipe.title
    expect(page).to have_link another_recipe.title
    # expect(recipe.destroyed?).to be true
  end

  scenario 'and only author can do it' do
    user = create :user
    author = create :user, email: 'palmirinha@campus.com'
    recipe = create :recipe, user: author

    login_as user

    visit root_path
    click_on recipe.title

    expect(page).not_to have_link 'Excluir receita'
    expect(page).to have_link 'Voltar'
  end
end