# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'faker'

Ingredient.destroy_all
Cocktail.destroy_all
Dose.destroy_all

filepath = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

ingredients = open(filepath).read

ingredients_ready = JSON.parse(ingredients)

ingredients_ready["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end

50.times do
  cocktail = Cocktail.new(name: Faker::Name.name)
  ingredient_1 = Ingredient.all.sample
  ingredient_2 = Ingredient.all.sample
  ingredient_3 = Ingredient.all.sample
  dose_1 = Dose.new(description: rand(1..9), cocktail: cocktail, ingredient: ingredient_1)
  dose_2 = Dose.new(description: rand(1..9), cocktail: cocktail, ingredient: ingredient_2)
  dose_3 = Dose.new(description: rand(1..9), cocktail: cocktail, ingredient: ingredient_3)
  dose_1.save
  dose_2.save
  dose_3.save
  cocktail.save
end
