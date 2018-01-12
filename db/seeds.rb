# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


arabian_cuisine = Cuisine.create(name: 'Arabe')
brazilian_cuisine = Cuisine.create(name: 'Brasileira')

appetizer_type = RecipeType.create(name: 'Entrada')
main_type = RecipeType.create(name: 'Prato Principal')
dessert_type = RecipeType.create(name: 'Sobremesa')

recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: dessert_type,
  cuisine: brazilian_cuisine, difficulty: 'Média', cook_time: 50,
  ingredients: 'Farinha, açucar, cenoura',
  method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

recipe2 = Recipe.create(title: 'Kebab', recipe_type: main_type,
  cuisine: arabian_cuisine, difficulty: 'Média', cook_time: 45,
  ingredients: 'Carne, Cebola, Pão Sírio',
  method: 'Cozinhe a carne, corte em pedaços pequenos, enrole no pão sírio')

recipe3 = Recipe.create(title: 'Tapioca de queijo branco', recipe_type: appetizer_type,
  cuisine: brazilian_cuisine, difficulty: 'Fácil', cook_time: 15,
  ingredients: 'Farinha de tapioca, queijo branco',
  method: 'Coloque 5 colheres de farinha de mandioca numa frigideira e em seguida coloque o queijo branco, feche a tapioca')