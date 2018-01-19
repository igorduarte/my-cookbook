FactoryBot.define do
  factory :recipe do
    title 'Paella'
    difficulty 'Média'
    ingredients 'Farinha, açúcar, cenoura'
    cook_time 60
    add_attribute(:method) { 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes' }
    recipe_type
    cuisine
    user
    image { File.new("#{Rails.root}/spec/support/fixtures/recipe_image.png") }
  end
end