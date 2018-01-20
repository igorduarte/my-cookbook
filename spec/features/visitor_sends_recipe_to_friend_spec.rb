require 'rails_helper'

feature 'Visitor sends a recipe to a friend via e-mail' do
  scenario 'succesfully' do
    friend_email = 'friend@email.com'
    recipe = create :recipe, title: 'Miojo'

    visit root_path
    click_on recipe.title
    fill_in 'Email', with: friend_email
    fill_in 'Mensagem', with: 'Olhe essa receita!'

    expect(RecipesMailer).to receive(:share).with(friend_email, 'Olhe essa receita!', recipe.id).and_call_original



    click_on 'Enviar'

    expect(page).to have_content "Receita enviada para #{friend_email}"
    expect(current_path).to eq recipe_path(recipe)
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to include friend_email
    expect(mail.subject).to eq 'Compartilharam uma receita com você :)'
    expect(mail.body).to include 'Olhe essa receita!'
    expect(mail.body).to include recipe_url(recipe, host: 'localhost:3000')

  end
end