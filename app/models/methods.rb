
#Finds which user is signed in
#Note: The 'exit' method signs out all users each time it is executed 
def which_user
    User.find_by(signed_in?: true)
end

#Determines whether there is a signed-in user
def is_signed_in
    which_user ?
    true : false
end

#Provides different welcome menu templates based on the user's signed-in status
def welcome
    is_signed_in ? welcome2 : welcome1
end

#Provides welcome menu template for user not signed in
def welcome1
    system "clear"
    welcome_graphic
    $prompt.select("Please choose from one of the following options:") do |menu|
        menu.choice "Order", -> { new_order }
        menu.choice "Sign In", -> { sign_in }
        menu.choice "Create Account", -> { create_account }
        menu.choice "Exit", -> { exit_method }
    end
end

#Provides welcome menu template for user signed in
def welcome2
    system "clear"
    welcome_graphic
    $prompt.select("Please choose from one of the following options:") do |menu|
        menu.choice "Order", -> { new_order }
        menu.choice "Account Information", -> { account_method }
        menu.choice "Sign Out", -> { sign_out }
        menu.choice "Exit", -> { exit_method }
    end
end

#Provides different order menu templates based on the user's signed-in status
def new_order
    is_signed_in ? order2 : order1
end

#Provides order menu template for user not signed in
def order1
    system "clear"
    order_graphic
    $prompt.select("Please choose from one of the following drink options:\n") do |menu|
        Drink.menu_items.each{|drink_instance| menu.choice name_price_ingredient(drink_instance), -> { order(drink_instance)}}
        menu.choice "Create your own\n", -> { customize }
        menu.choice "Go Back", -> { welcome }
    end 
end

#Provides order menu template for user signed in
#Difference from order1 method is the option to select from saved favorites
def order2
    system "clear"
    $prompt.select("Please choose from one of the following drink options:\n") do |menu|
        order_graphic
        Drink.menu_items.each{|drink_instance| menu.choice name_price_ingredient(drink_instance), -> { order(drink_instance)}}
        all_favorites.select{|favorite_instance| favorite_instance.drink.is_menu_item? == false}.each{|favorite_instance| menu.choice name_price_ingredient(favorite_instance.drink), -> { order(favorite_instance.drink)}}
        menu.choice "Create your own\n", -> { customize }
        menu.choice "Go Back", -> { welcome }
    end 
end

#Helper method used in order methods that provides the visual template for drink options 
def name_price_ingredient(drink_instance)
    "#{drink_instance.name} | $#{drink_instance.price} | #{(drink_instance.ingredients.map {|ingredient| ingredient.name}).join(", ")}\n"
end

#Allows users to created their own drink
def customize
    new_drink = Drink.create({is_menu_item?: false})
    selection = $prompt.multi_select("Please select ingredients", Ingredient.grouped_by_type.map {|instance| instance.name})
    selection.each {|ingredient_name| RecipeItem.create({drink_id: new_drink.id, ingredient_id: Ingredient.find_by(name: ingredient_name).id})}
    new_drink.update(price: selection.count.to_i)
    order(new_drink)
end 

#Allows user to view drink choice before confirming order
def order(drink_instance)
    system "clear"
    checkout_graphic
    if drink_instance.is_menu_item? == true
        puts "Drink name: #{drink_instance.name}"
    end
    puts "Ingredients: #{(drink_instance.ingredients.map {|ingredient| ingredient.name}).join(", ")}"
    puts "This drink costs $#{drink_instance.price}."
    $prompt.select("Would you like to CONFIRM ORDER or go back?:") do |menu|
        menu.choice "Confirm", -> {order_confirm(drink_instance)}
        menu.choice "Go back", -> {new_order}
    end
end

#Helper method to determine if a newly made order is already a favorite
def is_favorite?
    all_favorites.find {|favorite_order| favorite_order.drink_id == Order.last.drink_id}
end 

#Allows user to confirm drink order and displays drink information upon confirmation
#Allows signed-in user to save as favorite
def order_confirm(drink_instance)
    checkout_graphic
    if is_signed_in 
        Order.create({user_id: User.find_by(signed_in?: true).id, drink_id: drink_instance.id, price: drink_instance.price})
        if !is_favorite?
            Order.last.favorite
        end
        @order_array << Order.last
        another_drink(drink_instance)
    else
        Order.create({drink_id: drink_instance.id, price: drink_instance.price})
        @order_array << Order.last
        another_drink (drink_instance)
    end
end

#Informs user of successful order and total order price
def finalize_order(drink_instance)
    system "clear"
    nailed_it_graphic
    if @order_array.count == 1
        if drink_instance.is_menu_item?
            puts "You have successfully ordered a #{drink_instance.name} for a total of $#{drink_instance.price}. Thanks for coming!"
        else
            puts "You have successfully ordered a #{custom_drink_name} for a total of $#{drink_instance.price}. Thanks for coming!"
        end
    elsif @order_array.count == 2
        puts "You have successfully ordered a #{@order_array.first.drink.order_array_name} and #{@order_array.last.drink.order_array_name} for a total of $#{order_array_sum}."
    else
        puts "You have successfully ordered a \n#{@order_array[0, @order_array.count-1].map {|order| order.drink.order_array_name}.join(",\n")}, \nand #{@order_array.last.drink.order_array_name} \nfor a total of $#{order_array_sum}."
    end
    @order_array = []
    sleep (5)
    welcome
end

#Helper method to sum a total order
def order_array_sum
    @order_array.map {|order| order.price}.sum 
end

#Helper method to call a customized drink by this name
def custom_drink_name
    "Customized Drink"
end

#Allows user to either add another drink or complete order
def another_drink(drink_instance)
    system "clear"
    checkout_graphic
    $prompt.select("Would you like to ADD ANOTHER DRINK or COMPLETE ORDER?") do |menu|
        menu.choice "Add another drink", -> {new_order}
        menu.choice "Complete order", -> {finalize_order(drink_instance)}
    end
end

#Allows user to sign in
def sign_in
    puts "Please enter username or type 'exit' to exit"
    username = gets.chomp
    if username == "exit"
        welcome
    else
        if user = User.find_by(username: username)
            user.enter_password
        else
            puts "User does not exist"
            sleep (2)
            welcome
        end
    end
end

#Allows user to create an account with username and password
def create_account
    puts "Please enter a username or type 'exit' to return to the main menu:"
    username = gets.chomp
    if username == "exit"
        welcome
    elsif    
        User.find_by(username: username.downcase)
        puts "Username already exists."
        create_account
    else 
        password = $prompt.mask("Please create a password:")
        #Verifies password entry
        if password == $prompt.mask("Please re-enter password:")
            User.create({username: username, password: password, signed_in?: true})
            puts "Account username: \"#{username}\" created! You are now signed in!"
            sleep (2)
            welcome 
        else 
            puts "Passwords did not match, please try again."
            sleep (2)
            create_account
        end
    end 
end

#Provides account menu template only shown to signed-in user 
def account_method
    system "clear"
    account_info_graphic
    $prompt.select("Find the following account options:") do |menu|
        menu.choice "View my Order History", -> {see_orders}
        menu.choice "View my Favorites", -> {see_favorites}
        menu.choice "Delete my Account", -> {delete_account} 
        menu.choice "Go Back", -> {welcome} 
    end
end

#Allows user to view past orders
def see_orders
    system "clear"
    my_orders_graphic
    puts "Here is a list of your Orders:"
    which_user.orders.each {|order_instance| puts "~ #{order_instance.drink.name} \n\s\sPrice: $#{order_instance.drink.price} \n\s\sCreated: #{order_instance.created_at.to_s[0,10]}\n\n\t*********\n\n"}
        $prompt.select("Press 'enter' to return to the previous menu.") do |menu|
            menu.choice "", -> {account_method}
        end
end

#Allows user to view saved favorites
def see_favorites
    system "clear"
    favorites_graphic
    puts "Here is a list of your Favorites:"
    all_favorites.each {|order_instance| puts "~ #{order_instance.drink.name} | $#{order_instance.drink.price} | #{order_instance.drink.ingredients.map {|ingredient_instance|ingredient_instance.name}.join(", ")}\n"}
        $prompt.select("Press 'enter' to return to the previous menu.") do |menu|
            menu.choice "", -> {account_method}
        end
end
#Helper method which finds all instances of signed-in user's favorite orders
def all_favorites
    which_user.orders.select {|order_instance| order_instance.favorite? == true}
end

#Allows user to delete their own account
def delete_account
    system "clear"
    account_info_graphic
    $prompt.select("Would you like to DELETE your account?") do |menu|
        menu.choice "Delete", -> {which_user.orders.destroy_all; which_user.destroy; puts "Your account has been deleted."; sleep(2); welcome}
        menu.choice "Go back", -> {account_method} 
    end
end

#Allows user to sign out of their own account
def sign_out
    $prompt.select("Are you sure that you want to sign out?") do |menu|
        menu.choice "Yes", -> {which_user.update(signed_in?:false);welcome}
        menu.choice "No", -> {welcome}
    end
    
end

#Allows user to exit application
def exit_method
    system "clear"
    $background_music.fadeout(2000)
    puts "\n\t\t\tHave a Great Day!"
    sleep(0.5)
    $pop_sound_effect.play
    sleep(1)
    goodbye_graphic
    User.all.each {|user_instance| user_instance.update(signed_in?: false)}
    sleep (1.5)
    exit
end