class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :drink

    def favorite(drink_instance)
        $prompt.select("Would you like to add this order to your Favorites?") do |menu|
            menu.choice "Yes", -> {drink_instance.custom_favorite; self.update(favorite?: true); puts "#{drink_instance.name} added to Favorites!"; sleep (2)}
            menu.choice "No", -> {"#{drink_instance.name} not added to your Favorites"; sleep (2)}
        end
    end

    
end