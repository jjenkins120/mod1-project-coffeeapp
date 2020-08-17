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
User.create ({
    username: "batman",
    password: "robin",
    signed_in?: false
})

puts "☕️ seeding drinks"

Drink.create ({
    name: "Cafe Americano",
    price: 3
})
Drink.create ({
    name: "Cafe Latte",
    price: 5
})
Drink.create ({
    name: "London Fog Latte",
    price: 7
})
Drink.create ({
    name: "Macchiato",
    price: 5
})
Drink.create ({
    name: "Cappuccino",
    price: 5
})
Drink.create ({
    name: "Espresso",
    price: 3
})

puts "💲 seeding orders"

20.times do
    Order.create ({
            user_id: User.all.map{|user_instance| user_instance.id}.sample,
            drink_id: Drink.all.map{|drink_instance| drink_instance.id}.sample,
            #price: Drink.all.find(:drink_id).price,
            favorite?: [true,false].sample
        })
end

puts "🌿 seeding ingredients"

Ingredient.create ({
    name: "Espresso Shot"
    })

Ingredient.create ({
    name: "Steamed Milk"
})

Ingredient.create ({
    name: "Sugar"
})

Ingredient.create ({
    name: "Earl Grey Tea"
})

Ingredient.create ({
    name: "Vanilla Syrup"
})

Ingredient.create ({
    name: "Hot Water"
})

Ingredient.create ({
    name: "Hazelnut"
})

Ingredient.create ({
    name: "Chocolate"
})

Ingredient.create ({
    name: "Cinnamon"
})

Ingredient.create ({
    name: "Whipped Cream"
})

Ingredient.create ({
    name: "Caramel"
})


puts "📃 seeding recipe_items"


RecipeItem.create ({
        drink_id: Drink.all.find_by(name: "Cafe Americano").id,
        ingredient_id: Ingredient.all.find_by(name: "Espresso Shot").id
    })

RecipeItem.create ({
        drink_id: Drink.all.find_by(name: "Cafe Latte").id,
        ingredient_id: Ingredient.all.find_by(name: "Steamed Milk").id
    })

RecipeItem.create ({
        drink_id: Drink.all.find_by(name: "London Fog Latte").id,
        ingredient_id: Ingredient.all.find_by(name: "Earl Grey Tea").id
    })    
    

puts "✨Done!"