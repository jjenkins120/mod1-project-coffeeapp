class Ingredient < ActiveRecord::Base
    has_many :recipe_items
    has_many :drinks, through: :recipe_items
#helper method to sort ingredients by type
    def self.grouped_by_type
        self.order(:ingredient_type)
    end
end