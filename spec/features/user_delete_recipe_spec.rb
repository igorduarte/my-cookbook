require 'rails_helper'

feature 'User delete recipe' do
  scenario 'succesfully' do
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    user = create :user
    recipe = create :recipe, recipe_type: recipe_type,
      cuisine: cuisine, user: user

    login_as user, scope: :user

    visit root_path
    click_link recipe.title
    click_on "Excluir Receita"

    expect(current_path).to eq root_path
    expect(Recipe.all).not_to include recipe

    # expect(confirm).to eq('Tem certeza?')
    # expect(recipe.destroyed?).to be true
  end
end