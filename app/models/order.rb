class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :drink

    def self.new_order
        prompt = TTY::Prompt.new
        prompt.select("Please choose from one of the following drink options:") do |menu|
            system "clear"
            Drink.all.each{|drink_instance| menu.choice "#{drink_instance.name} | #{(drink_instance.ingredients.map {|ingredient| ingredient.name}).join()} | $#{drink_instance.price}", -> { Order.order(drink_instance)}}
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
            Order.last.favorite
        else
            Order.create({drink_id: drink_instance.id, price: drink_instance.price})
        end
        system "clear"
        puts "You have successfully ordered a #{drink_instance.name}. Thank you for your patronage."
        sleep (3)
        welcome
    end

    def favorite
        prompt = TTY::Prompt.new
        prompt.select("Would you like to add this order to your Favorites?") do |menu|
            menu.choice "Yes", -> {self.update(favorite?: true); puts "Added to favorites!"; sleep (2)}
            menu.choice "No", -> {"Order not added to your Favorites"}
        end
    end




end