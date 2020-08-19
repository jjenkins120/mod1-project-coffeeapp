puts "💣 destroying instances"

Ingredient.destroy_all
Order.destroy_all
User.destroy_all
RecipeItem.destroy_all
Drink.destroy_all

#puts "🦹‍♀️ seeding users"

puts "☕️ seeding drinks"

Drink.create ({
    name: "Cafe Americano",
    price: 3,
    is_menu_item?: true
})
Drink.create ({
    name: "Cafe Latte",
    price: 5,
    is_menu_item?: true
})
Drink.create ({
    name: "London Fog Latte",
    price: 7,
    is_menu_item?: true
})
Drink.create ({
    name: "Macchiato",
    price: 5,
    is_menu_item?: true
})
Drink.create ({
    name: "Cappuccino",
    price: 5,
    is_menu_item?: true
})
Drink.create ({
    name: "Espresso",
    price: 3,
    is_menu_item?: true
})

#puts "💲 seeding orders"

# 20.times do
#     Order.create ({
#             user_id: User.all.map{|user_instance| user_instance.id}.sample,
#             drink_id: Drink.all.map{|drink_instance| drink_instance.id}.sample,
#             #price: Drink.all.find(:drink_id).price,
#             favorite?: [true,false].sample
#         })
# end

puts "🌿 seeding ingredients"

Ingredient.create ({
    name: "Espresso (2 Shots)",
    ingredient_type: "Base"
    })

Ingredient.create ({
    name: "Steamed Milk",
    ingredient_type: "Milk/Water"
})

Ingredient.create ({
    name: "Sugar",
    ingredient_type: "Topping"
})

Ingredient.create ({
    name: "Earl Grey Tea",
    ingredient_type: "Base"
})

Ingredient.create ({
    name: "Vanilla Syrup",
    ingredient_type: "Syrup"
})

Ingredient.create ({
    name: "Hot Water",
    ingredient_type: "Milk/Water"
})

Ingredient.create ({
    name: "Hazelnut",
    ingredient_type: "Syrup"
})

Ingredient.create ({
    name: "Chocolate",
    ingredient_type: "Topping"
})

Ingredient.create ({
    name: "Cinnamon",
    ingredient_type: "Topping"
})

Ingredient.create ({
    name: "Whipped Cream",
    ingredient_type: "Topping"
})

Ingredient.create ({
    name: "Caramel",
    ingredient_type: "Topping"
})
Ingredient.create ({
    name: "Caramel Syrup",
    ingredient_type: "Syrup"
})
Ingredient.create ({
    name: "Almond Milk",
    ingredient_type: "Milk/Water"
})


puts "📃 seeding recipe_items"


RecipeItem.create ({
        drink_id: Drink.all.find_by(name: "Cafe Americano").id,
        ingredient_id: Ingredient.all.find_by(name: "Espresso (2 Shots)").id
    })

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Cafe Americano").id,
    ingredient_id: Ingredient.find_by(name: "Hot Water").id 
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Cafe Latte").id,
    ingredient_id: Ingredient.find_by(name: "Espresso (2 Shots)").id 
})

RecipeItem.create ({
        drink_id: Drink.all.find_by(name: "Cafe Latte").id,
        ingredient_id: Ingredient.all.find_by(name: "Steamed Milk").id
    })

RecipeItem.create ({
        drink_id: Drink.all.find_by(name: "London Fog Latte").id,
        ingredient_id: Ingredient.all.find_by(name: "Earl Grey Tea").id
    })
    
RecipeItem.create ({
    drink_id: Drink.find_by(name: "London Fog Latte").id,
    ingredient_id: Ingredient.find_by(name: "Steamed Milk").id 
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "London Fog Latte").id,
    ingredient_id: Ingredient.find_by(name: "Vanilla Syrup").id 
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Macchiato").id,
    ingredient_id: Ingredient.find_by(name: "Espresso (2 Shots)").id
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Macchiato").id,
    ingredient_id: Ingredient.find_by(name: "Steamed Milk").id 
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Macchiato").id,
    ingredient_id: Ingredient.find_by(name: "Chocolate").id 
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Macchiato").id,
    ingredient_id: Ingredient.find_by(name: "Whipped Cream").id 
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Cappuccino").id,
    ingredient_id: Ingredient.find_by(name: "Espresso (2 Shots)").id 
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Cappuccino").id,
    ingredient_id: Ingredient.find_by(name: "Steamed Milk").id 
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Cappuccino").id,
    ingredient_id: Ingredient.find_by(name: "Sugar").id 
})

RecipeItem.create ({
    drink_id: Drink.find_by(name: "Espresso").id,
    ingredient_id: Ingredient.find_by(name: "Espresso (2 Shots)").id 
})

puts "✨Done!"