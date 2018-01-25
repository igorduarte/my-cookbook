require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page)
      .to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
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
    old_recipe = create :recipe, title: 'Receita antiga', cuisine: cuisine,
      recipe_type: recipe_type, user: user
    recipes = create_list(:recipe, 6, cuisine: cuisine,
      recipe_type: recipe_type, user: user)

    login_as user

    visit root_path

    expect(page).to have_link recipes[0].title
    expect(page).to have_css 'div.col-md-12', count: 6
    expect(page).not_to have_link old_recipe.title
    expect(page).not_to have_css 'div.col-md-12', count: 7
  end

  scenario 'and click link to see all recipes' do
    user = create :user
    cuisine = create :cuisine
    recipe_type = create :recipe_type
    recipes = create_list(:recipe, 10, cuisine: cuisine,
      recipe_type: recipe_type, user: user)

    login_as user

    visit root_path
    click_link 'Ver todas as receitas'

    expect(current_path).to eq recipes_path
    expect(page).to have_css 'div.col-md-12', count: 10
    expect(page).to have_link recipes[0].title
    expect(page).to have_link recipes[9].title
  end

  scenario 'and see 3 most favorited recipes' do
    users = create_list :user, 3
    cuisine = create :cuisine
    type = create :recipe_type

    most_favorite_recipe = create :recipe, title: 'Feijoada', user: users[0],
      cuisine: cuisine, recipe_type: type
    second_favorite_recipe = create :recipe, title: 'Miojo', user: users[0],
      cuisine: cuisine, recipe_type: type
    less_favorite_recipe = create :recipe, title: 'Churrasco', user: users[0],
      cuisine: cuisine, recipe_type: type

    no_favorited_recipe = create :recipe, title: 'Picolé de chuchu',
    user: users[0], cuisine: cuisine, recipe_type: type


    create_list :favorite, 3, recipe: most_favorite_recipe, user: users[0]
    create_list :favorite, 2, recipe: second_favorite_recipe, user: users[0]
    create_list :favorite, 1, recipe: less_favorite_recipe, user: users[0]

    visit root_path

    expect(page).to have_css 'div.col-md-12.col-xs-2.favorites', count: 3
    expect(page).to have_link most_favorite_recipe.title
    expect(page).to have_link less_favorite_recipe.title
    expect(page).to have_link second_favorite_recipe.title
    expect(page).not_to have_css 'section.col-md-5.favorites',
      text: no_favorited_recipe.title
    expect(page).not_to have_css 'div.col-md-12.col-xs-2.favorites', count: 4

  end

  scenario 'and see highlighted recipes' do
      user = create :user
      cuisine = create :cuisine, name: 'Arabe'
      recipe_type = create :recipe_type, name: 'Entrada'
      create :recipe, title: 'Tabule', cuisine: cuisine,
        recipe_type: recipe_type, user: user, star: true

      login_as user

      visit root_path

      expect(page).to have_css %{img[src*='/assets/star-0582542e7338ffe28bc
        07bcd06e2a047d529743295cb753916c435368db3838b.png']}.gsub(/\s+/, "")
  end
end
