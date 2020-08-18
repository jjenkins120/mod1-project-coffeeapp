

def see_orders
    system "clear"
    puts "Here is a list of your Orders:"
    User.which_user.orders.each {|order_instance| puts "~ #{order_instance.drink.name} \n\s\sPrice: $#{order_instance.drink.price} \n\s\sCreated: #{order_instance.created_at.to_s[0,10]}\n\n\t*********\n\n"}
    #prompt = TTY::Prompt.new
        $prompt.select("Press 'enter' to return to the previous menu.") do |menu|
            menu.choice "", -> {account_method}
        end
end

def see_favorites
    system "clear"
    puts "Here is a list of your Favorites:"
    uniq_favorites.each {|drink_name| puts "~ #{drink_name} | $#{Drink.find_by(name:drink_name).price} | #{Drink.find_by(name:drink_name).ingredients.map {|ingredient_instance|ingredient_instance.name}.join(", ")}\n"}
    #prompt = TTY::Prompt.new
        $prompt.select("Press 'enter' to return to the previous menu.") do |menu|
            menu.choice "", -> {account_method}
        end
end

def uniq_favorites
    favorites_array = User.which_user.orders.select {|order_instance| order_instance.favorite? == true}
    favorites_array = favorites_array.map{|favorite| favorite.drink.name}.uniq
end

def delete_account
    system "clear"
    #prompt = TTY::Prompt.new
    $prompt.select("Would you like to DELETE your account?") do |menu|
        menu.choice "Delete", -> {User.which_user.orders.destroy_all; User.which_user.destroy; puts "Your account has been deleted."; sleep(2); welcome}
        menu.choice "Go back", -> {account_method} 
    end
end

def account_method
    system "clear"
    #prompt = TTY::Prompt.new
    $prompt.select("Find the following account options:") do |menu|
        menu.choice "View my Order History", -> {see_orders}
        menu.choice "View my Favorites", -> {see_favorites}
        menu.choice "Delete my Account", -> {delete_account} 
        menu.choice "Go Back", -> {welcome} 
    end
end

