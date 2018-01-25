require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do
    user = create :user
    login_as user

    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content
      'Nenhuma receita encontrada para este tipo de Cozinha'
  end

  scenario 'and must fill in name' do
    user = create :user
    login_as user

    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'do not accept duplicate cuisines' do
    user = create :user
    login_as user

    create :cuisine, name: 'Brasileira'

    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end
end
