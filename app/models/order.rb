class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :drink

    def self.new_order
        prompt = TTY::Prompt.new
        prompt.select("Please choose from one of the following drink options:") do |menu|
            system "clear"
            Drink.menu_items.each{|drink_instance| menu.choice "#{drink_instance.name} | #{(drink_instance.ingredients.map {|ingredient| ingredient.name}).join()} | $#{drink_instance.price}", -> { Order.order(drink_instance)}}
            menu.choice "Create your own", -> { Order.customize }
            menu.choice "Go Back", -> { welcome }
        end 
    end
    

    def self.order(drink_instance)
        system "clear"
        puts "Ingredients: #{(drink_instance.ingredients.map {|ingredient| ingredient.name}).join()}"
        puts "This drink costs $#{drink_instance.price}."
        prompt = TTY::Prompt.new
        prompt.select("Would you like to CONFIRM ORDER or go back?:") do |menu|
            menu.choice "Confirm", -> {Order.order_confirm(drink_instance)}
            menu.choice "Go back", -> {Order.new_order}
        end
    end

    def self.order_confirm(drink_instance)
        if User.is_signed_in 
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

    def favorite(drink_instance)
        prompt = TTY::Prompt.new
        prompt.select("Would you like to add this order to your Favorites?") do |menu|
            menu.choice "Yes", -> {drink_instance.custom_favorite; self.update(favorite?: true); puts "#{drink_instance.name} added to Favorites!"; sleep (2)}
            menu.choice "No", -> {"#{drink_instance.name} not added to your Favorites"; sleep (2)}
        end
    end


    def self.customize
        new_drink = Drink.create({price: 8, is_menu_item?: false})
        prompt = TTY::Prompt.new
        selection = prompt.multi_select("Please select ingredients", Ingredient.all.map {|instance| instance.name})
        selection.each {|ingredient_name| RecipeItem.create({drink_id: new_drink.id, ingredient_id: Ingredient.find_by(name: ingredient_name).id})}
        Order.order(new_drink)
    end 

        


end