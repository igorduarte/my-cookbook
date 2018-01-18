class RecipesMailerPreview < ActionMailer::Preview
  def share
    @email = 'igor.duarte@live.com'
    @message = 'Parabéns'
    @recipe = Recipe.find(1)
    RecipesMailer.share(@email, @message, @recipe.id)
  end
end