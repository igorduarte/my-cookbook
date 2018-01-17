require 'rails_helper'

feature 'Visitor search for recipes' do
  scenario 'from home page' do
    # cria os dados necessários previamente
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    another_recipe_type = create :recipe_type, name: 'Entrada'
    recipe = create :recipe, cuisine: cuisine, recipe_type: recipe_type
    another_recipe = create :recipe, title: 'Salada de cenoura',
      cuisine: cuisine, recipe_type: recipe_type

    # simula a ação do usuário
    visit root_path
    fill_in 'search', with: recipe.title
    click_on 'Buscar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h2', text: "Resultado da busca por #{recipe.title}")
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'and navigate to recipe details' do
    # cria os dados necessários previamente
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    user = create :user
    recipe = create :recipe, cuisine: cuisine,
      recipe_type: recipe_type, user: user

    # simula a ação do usuário
    visit root_path
    fill_in 'search', with: recipe.title
    click_on 'Buscar'
    click_on recipe.title

    # expectativas do usuário após a ação
    expect(current_path).to eq(recipe_path(recipe))
  end

  scenario 'and find recipe by title' do
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, title: 'Bolo de cenoura',
      ingredients: 'Farinha, açucar, cenoura',
      cuisine: cuisine, recipe_type: recipe_type

    another_recipe = create :recipe, title: 'Pavê',
      ingredients: 'Chocolate, bolacha e açucar',
      cuisine: cuisine, recipe_type: recipe_type

    visit root_path
    fill_in 'search', with: recipe.title
    click_on 'Buscar'

    expect(page).to have_css('h2', text: "Resultado da busca por #{recipe.title}")
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'and ingredients' do
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, title: 'Bolo de cenoura',
      ingredients: 'Farinha, açucar, cenoura e chocolate',
      cuisine: cuisine, recipe_type: recipe_type

    another_recipe = create :recipe, title: 'Pavê de chocolate',
      ingredients: 'bolacha e açucar',
      cuisine: cuisine, recipe_type: recipe_type

    third_recipe = create :recipe ,title: 'Brigadeiro Branco',
      ingredients: 'Baunilha, bolacha e açucar',
      cuisine: cuisine, recipe_type: recipe_type

    search_term = 'chocolate'

    visit root_path
    fill_in 'search', with: search_term
    click_on 'Buscar'

    expect(page).to have_css('h2', text: "Resultado da busca por #{search_term}")
    expect(page).to have_css('h1', text: recipe.title)
    # expect(page).to have_css('p', text: recipe.ingredients)
    expect(page).to have_css('h1', text: another_recipe.title)
    # expect(page).to have_css('p', text: another_recipe.ingredients)
    expect(page).not_to have_css('h1', text: third_recipe.title)
    expect(page).to have_css('div.recipes', count: 2 )
  end

  scenario 'and does not find any recipe' do
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipe = create :recipe, title: 'Bolo de cenoura',
      ingredients: 'Farinha, açucar, cenoura e chocolate',
      cuisine: cuisine, recipe_type: recipe_type

    another_recipe = create :recipe, title: 'Pavê de chocolate',
      ingredients: 'Cacau, bolacha e açucar',
      cuisine: cuisine, recipe_type: recipe_type

    search_term = 'Abacaxi'

    visit root_path
    fill_in 'search', with: search_term
    click_on 'Buscar'

    expect(page).to have_css('p', text: "Nenhuma receita encontrada com o termo #{search_term}")
    expect(page).to have_css('div.recipes', count: 0 )
   end
end
