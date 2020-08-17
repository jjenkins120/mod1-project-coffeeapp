puts "destroying instances"

Order.destroy_all
RecipeItem.destroy_all
Drink.destroy_all
User.destroy_all
Ingredient.destroy_all

puts "🦹‍♀️ seeding users"

20.times do 
    User.create ({
        username: Faker::Name.name,
        password: Faker::String.random(length: 4),
        signed_in?: [true,false].sample
    })
end

puts "☕️ seeding drinks"

20.times do
    Drink.create ({
            name: Faker::Coffee.blend_name,
            price: rand(3..15)
    })
end

puts "💲 seeding orders"

20.times do
    Order.create ({
            user_id: User.all.map{|user_instance| user_instance.id}.sample,
            drink_id: Drink.all.map{|drink_instance| drink_instance.id}.sample,
            price: rand(3..15),
            favorite?: [true,false].sample
        })
end

puts "🌿 seeding ingredients"
20.times do
    Ingredient.create ({
            name: Faker::Food.ingredient
        })
end

puts "📃 seeding recipe_items"

20.times do
    RecipeItem.create ({
            drink_id: Drink.all.map{|drink_instance| drink_instance.id}.sample,
            ingredient_id: Ingredient.all.map{|ingredient_instance| ingredient_instance.id}.sample
        })
end

puts "✨Done!"