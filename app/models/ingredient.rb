class Ingredient < ActiveRecord::Base
    has_many :recipe_items
    has_many :drinks, through: :recipe_items
end