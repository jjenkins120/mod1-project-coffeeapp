class Drink < ActiveRecord::Base
    has_many :orders
    has_many :users, through: :orders
    has_many :recipe_items
    has_many :ingredients, through: :recipe_items

    def self.menu_items
        Drink.all.select {|drink_instance| drink_instance.is_menu_item? == true}
    end

    def custom_favorite
        if self.is_menu_item? == false 
        puts "Please create a name for your new drink:"
        response = gets.chomp
        self.update(name: response.to_s)
        end
    end
end