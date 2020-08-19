
def exit_method
    puts "Thank you. Have a great day. Goodbye!"
    User.all.each {|user_instance| user_instance.update(signed_in?: false)}
    sleep (1.5)
    exit
end

def welcome1
    system "clear"
    $prompt.select("Please choose from one of the following options:") do |menu|
        menu.choice "Order", -> { new_order }
        menu.choice "Sign In", -> { sign_in }
        menu.choice "Create Account", -> { create_account }
        menu.choice "Exit", -> { exit_method }
    end
end

def welcome2
    system "clear"
    $prompt.select("Please choose from one of the following options:") do |menu|
        menu.choice "Order", -> { new_order }
        menu.choice "Account Information", -> { account_method }
        menu.choice "Sign Out", -> { sign_out }
        menu.choice "Exit", -> { exit_method }
    end
end

def see_orders
    system "clear"
    puts "Here is a list of your Orders:"
    which_user.orders.each {|order_instance| puts "~ #{order_instance.drink.name} \n\s\sPrice: $#{order_instance.drink.price} \n\s\sCreated: #{order_instance.created_at.to_s[0,10]}\n\n\t*********\n\n"}
        $prompt.select("Press 'enter' to return to the previous menu.") do |menu|
            menu.choice "", -> {account_method}
        end
end

def see_favorites
    system "clear"
    puts "Here is a list of your Favorites:"
    uniq_favorites.each {|drink_name| puts "~ #{drink_name} | $#{Drink.find_by(name:drink_name).price} | #{Drink.find_by(name:drink_name).ingredients.map {|ingredient_instance|ingredient_instance.name}.join(", ")}\n"}
        $prompt.select("Press 'enter' to return to the previous menu.") do |menu|
            menu.choice "", -> {account_method}
        end
end

def uniq_favorites
    favorites_array = which_user.orders.select {|order_instance| order_instance.favorite? == true}
    favorites_array = favorites_array.map{|favorite| favorite.drink.name}.uniq
end

def delete_account
    system "clear"
    $prompt.select("Would you like to DELETE your account?") do |menu|
        menu.choice "Delete", -> {which_user.orders.destroy_all; which_user.destroy; puts "Your account has been deleted."; sleep(2); welcome}
        menu.choice "Go back", -> {account_method} 
    end
end

def account_method
    system "clear"
    $prompt.select("Find the following account options:") do |menu|
        menu.choice "View my Order History", -> {see_orders}
        menu.choice "View my Favorites", -> {see_favorites}
        menu.choice "Delete my Account", -> {delete_account} 
        menu.choice "Go Back", -> {welcome} 
    end
end

def new_order
    is_signed_in ? order2 : order1
end

def order1
    $prompt.select("Please choose from one of the following drink options:\n") do |menu|
        system "clear"
        Drink.menu_items.each{|drink_instance| menu.choice name_price_ingredient(drink_instance), -> { order(drink_instance)}}
        menu.choice "Create your own\n", -> { customize }
        menu.choice "Go Back", -> { welcome }
    end 
end

def order2
    $prompt.select("Please choose from one of the following drink options:\n") do |menu|
        system "clear"
        Drink.menu_items.each{|drink_instance| menu.choice name_price_ingredient(drink_instance), -> { order(drink_instance)}}
        uniq_favorites.select{|drink_name| Drink.find_by(name: drink_name).is_menu_item? == false}.each{|drink_name| menu.choice name_price_ingredient(Drink.find_by(name: drink_name)), -> { order(Drink.find_by(name: drink_name))}}
        menu.choice "Create your own\n", -> { customize }
        menu.choice "Go Back", -> { welcome }
    end 
end

def name_price_ingredient(drink_instance)
    "#{drink_instance.name} | $#{drink_instance.price} | #{(drink_instance.ingredients.map {|ingredient| ingredient.name}).join(", ")}\n"
end


def order(drink_instance)
    system "clear"
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

def order_confirm(drink_instance)
    if is_signed_in 
        Order.create({user_id: User.find_by(signed_in?: true).id, drink_id: drink_instance.id, price: drink_instance.price})
        Order.last.favorite(drink_instance)
    else
        Order.create({drink_id: drink_instance.id, price: drink_instance.price})
    end
    system "clear"
    puts "You have successfully ordered a #{drink_instance.name}. Thanks for coming!"
    sleep (3)
    welcome
end

def customize
    new_drink = Drink.create({price: 8, is_menu_item?: false})
    selection = $prompt.multi_select("Please select ingredients", Ingredient.all.map {|instance| instance.name})
    selection.each {|ingredient_name| RecipeItem.create({drink_id: new_drink.id, ingredient_id: Ingredient.find_by(name: ingredient_name).id})}
    order(new_drink)
end 


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

def sign_out
    $prompt.select("Are you sure that you want to sign out?") do |menu|
        menu.choice "Yes", -> {which_user.update(signed_in?:false);welcome}
        menu.choice "No", -> {welcome}
    end
    
end

def create_account
    puts "Please enter a username or type 'exit' to return to the main menu:"
    username = gets.chomp
    if username == "exit"
        welcome
    elsif    
        find_by(username: username.downcase)
        puts "Username already exists."
        create_account
    else 

        password = $prompt.mask("Please create a password:")
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

def is_signed_in
    which_user ?
    true : false
end

def which_user
    User.find_by(signed_in?: true)
end

