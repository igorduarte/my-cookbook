require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    #cria os dados necessários
    create :cuisine, name: 'Arabe'
    create :recipe_type, name: 'Entrada'
    create :recipe_type, name: 'Prato Principal'
    create :recipe_type, name: 'Sobremesa'

    user = create :user
    login_as user
    # simula a ação do usuário
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with:
    'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with:
    'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text:
      'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:
      'Misturar tudo e servir. Adicione limão a gosto.')
  end

  scenario 'and must fill in all fields' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    create :cuisine, name: 'Arabe'
    user = create :user
    login_as user
    # simula a ação do usuário
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and must be authenticated' do
    create :user

    visit root_path
    click_on 'Enviar uma receita'

    expect(page).to have_content :unauthenticated
    expect(current_path).not_to eq(new_recipe_path)
  end

  scenario 'and must be authenticated (via URI)' do

    visit new_recipe_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content :unauthenticated
  end

  scenario 'and can add an image to recipe' do
    user = create :user
    cuisine = create :cuisine, name: 'Arabe'
    recipe_type = create :recipe_type, name: 'Entrada'
    recipe = create :recipe, title: 'Tabule', cuisine: cuisine,
      recipe_type: recipe_type, user: user

    login_as user

    visit root_path
    click_on recipe.title
    click_on 'Editar'
    page.attach_file(:recipe_image, './spec//support/fixtures/recipe_image.png')
    click_on 'Enviar'

    expect(page).to have_css "img[src*='recipe_image.png']"
  end

  scenario 'and can put a star on it' do
    user = create :user
    cuisine = create :cuisine, name: 'Arabe'
    recipe_type = create :recipe_type, name: 'Entrada'
    create :recipe, title: 'Tabule', cuisine: cuisine,
      recipe_type: recipe_type, user: user

    login_as user

    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    check 'recipe_star'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with:
    'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with:
    'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css %{img[src*='/assets/star-0582542e7338ffe28bc
      07bcd06e2a047d529743295cb753916c435368db3838b.png']}.gsub(/\s+/, "")
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text:
      'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:
      'Misturar tudo e servir. Adicione limão a gosto.')

  end
end
