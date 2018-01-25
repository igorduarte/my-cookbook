require 'rails_helper'

feature 'User favorites recipes' do
  scenario 'succesfully' do
    user = create :user
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine,
      user: user

    login_as user

    visit root_path
    click_link recipe.title

    expect(page).to have_content('Favoritar Receita')
  end

  scenario 'and another user favorites too' do
    user = create :user
    another_user = create :user, email: 'another@campus.com'
    recipe = create :recipe, user: user
    create :favorite, user: user, recipe: recipe

    login_as another_user

    visit recipe_path(recipe)
    # click_on recipe.title
    click_on 'Favoritar Receita'

    expect(page).to have_content('Receita adicionada aos favoritos')
    expect(page).not_to have_button('Favoritar Receita')
  end

  scenario 'and unfavorite' do
    user = create :user
    recipe = create :recipe, user: user
    create :favorite, user: user, recipe: recipe

    login_as user
    visit recipe_path(recipe)
    click_on 'Remover dos favoritos'

    expect(page).to have_content 'Receita removida dos favoritos'
    expect(page).not_to have_link 'Remover dos favoritos'
    expect(page).to have_link 'Favoritar Receita'
  end
end