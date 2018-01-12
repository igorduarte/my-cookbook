require 'rails_helper'

feature 'User login' do
  scenario 'successfully' do
    user = create(:user, email: "igor@campuscode.com", password: "10203040")

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'

    expect(page).to have_content("Bem vindo #{user.email}")
    expect(page).not_to have_content("Entrar")
  end
end