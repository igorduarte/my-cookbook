FactoryBot.define do
  factory :recipe do
    title 'Paella'
    difficulty 'Média'
    ingredients 'Arroz e Frutos do mar'
    cook_time 60
    add_attribute(:method) { 'Cozinhe o arroz e misture com o restante dos ingredientes' }
    recipe_type
    cuisine
    user
    image { File.new("#{Rails.root}/spec/support/fixtures/recipe_image.png") }
  end
end