require 'rails_helper'

feature 'User login' do
  scenario 'successfully' do
    user = create :user
    logout :user

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_button 'Login'

    expect(page).to have_content :signed_in
    expect(page).to have_content "Bem vindo #{user.email}"
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end

  scenario 'and logout' do
    user = create :user
    login_as user, scope: :user

    visit root_path
    click_on 'Sair'

    expect(page).to have_content :signed_out
    expect(page).to have_content "Entrar"
    expect(page).not_to have_link "Sair"
    expect(page).not_to have_content "Bem vindo #{user.email}"
  end
end