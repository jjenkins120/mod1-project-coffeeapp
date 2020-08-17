class CreateRecipeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_items do |t|
      t.integer :drink_id
      t.integer :ingredient_id
      t.timestamps
    end
  end
end


#Recipe_item: drink_id(int), ingredient_id(int)