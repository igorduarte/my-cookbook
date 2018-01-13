FactoryBot.define do
  factory :recipe do
    title 'Bolo'
    difficulty 'Média'
    ingredients 'Farinha, açúcar, cenoura'
    cook_time 60
    add_attribute(:method) { 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes' }
    recipe_type
    cuisine
    # association :author, factory: :user, name: "Igor"
  end
end