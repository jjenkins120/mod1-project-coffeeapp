class Drink < ActiveRecord::Base
    has_many :orders
    has_many :users, through: :orders
    has_many :recipe_items
    has_many :ingredients, through: :recipe_items
end