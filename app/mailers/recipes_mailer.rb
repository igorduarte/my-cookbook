class RecipesMailer < ApplicationMailer
  default from: 'no-reply@cookbook.com'

  def share(email, message, recipe_id)
    @recipe = Recipe.find(recipe_id)
    @message = message
    mail to: email,
         subject: 'Compartilharam uma receita com você :)',
         body: @message
  end
end