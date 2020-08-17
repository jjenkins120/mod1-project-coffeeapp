class CreateDrinks < ActiveRecord::Migration[5.2]
  def change
    create_table :drinks do |t|
      t.string :name
      t.integer :price
      t.timestamps
    end
  end
end


#Drink: name(str), price(int)