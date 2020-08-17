class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :drink_id
      t.integer :price
      t.boolean :favorite?
      t.timestamps
    end
  end
end


#Order: user_id (int), drink_id(int), price(int), favorite?(boolean)