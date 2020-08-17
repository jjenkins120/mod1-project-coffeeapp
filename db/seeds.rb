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
    name: "Cappucino",
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
    name: "espresso shot"
    })

Ingredient.create ({
    name: "steamed milk"
})

Ingredient.create ({
    name: "sugar"
})

Ingredient.create ({
    name: "earl grey tea"
})

Ingredient.create ({
    name: "vanilla syrup"
})

Ingredient.create ({
    name: "hot water"
})

Ingredient.create ({
    name: "hazelnut"
})

Ingredient.create ({
    name: "chocolate"
})

Ingredient.create ({
    name: "cinnamon"
})

Ingredient.create ({
    name: "whipped cream"
})

Ingredient.create ({
    name: "caramel"
})


puts "📃 seeding recipe_items"


RecipeItem.create ({
        drink_id: Drink.all.find_by(name: "Cafe Americano").id,
        ingredient_id: Drink.all.find_by(name: "espresso shot").id
    })

RecipeItem.create ({
        drink_id: Drink.all.find_by(name: "Cafe Latte").id,
        ingredient_id: Drink.all.find_by(name: "steamed milk").id
    })

RecipeItem.create ({
        drink_id: Drink.all.find_by(name: "London Fog Latte").id,
        ingredient_id: Drink.all.find_by(name: "earl grey tea").id
    })    
    

puts "✨Done!"