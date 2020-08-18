class AddMenuColumnToDrinks < ActiveRecord::Migration[5.2]
  def change
    add_column :drinks, :is_menu_item?, :boolean
  end
end
