class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :drink

    #Helper method that gives signed-in user option to save drink to favorites
    def favorite
        drink = Order.last.drink
        $prompt.select("Would you like to add this order to your Favorites?") do |menu|
            menu.choice "Yes", -> {drink.custom_favorite; self.update(favorite?: true); puts "#{drink.name} added to Favorites!"; sleep (2)}
            menu.choice "No", -> {puts "#{drink.order_array_name} not added to your Favorites."; sleep (2)}
        end
    end

end