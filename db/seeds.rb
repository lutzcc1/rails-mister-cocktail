require 'open-uri'
require 'json'

buffer = open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read
ingredients = JSON.parse(buffer)

ingredients['drinks'].each do |hash_ingredient|
  Ingredient.create!(name: hash_ingredient['strIngredient1'])
  puts "#{hash_ingredient['strIngredient1']} added to the DB"
end

Ingredient.create!(name: 'Ice')
Ingredient.create!(name: 'Cola Soda')
Ingredient.create!(name: 'Salt')
Ingredient.create!(name: 'Sugar')
