require 'rails_helper'

RSpec.describe RecipesMailer, :type => :mailer do
  describe 'share' do
    it 'builds the email' do
      user = create :user, email: 'igor@campus.com'
      message = 'Compartilharam uma receita com você :)'
      recipe = create :recipe, user: user

      mail = RecipesMailer.share(user.email , message, recipe.id)

      expect(mail.to).to include user.email
      expect(mail.subject).to eq message
      expect(mail.from).to include 'no-reply@cookbook.com'
      expect(mail.body).to include message
      # expect(mail.body).to include recipe_url(recipe)

    end
  end
end