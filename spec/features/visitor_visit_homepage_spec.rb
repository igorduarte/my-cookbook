require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipe list' do
    #cria os dados necessários
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, recipe_type: recipe_type, cuisine: cuisine

    another_recipe_type = create(:recipe_type, name: 'Prato Principal')
    another_recipe = create(:recipe, title: 'Feijoada',
      recipe_type: another_recipe_type, cuisine: cuisine,
      difficulty: 'Difícil', ingredients: 'Feijao, paio, carne seca',
      method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
      cook_time: 90)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and view recipe list with 6 last ones' do
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
