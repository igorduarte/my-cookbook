require 'rails_helper'

feature 'User register recipe_type' do
  scenario 'successfully' do
    user = create :user
    login_as user

    visit new_recipe_type_path
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).to have_content
      %{Nenhuma receita encontrada para este tipo de receitas'}
  end

  scenario 'and must fill in name' do
    user = create :user
    login_as user

    visit new_recipe_type_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome do tipo de receita')
  end
end
