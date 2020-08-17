class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.boolean :signed_in?
      t.timestamps
    end
  end
end

#User: username(str), password (str), signed in?(boolean)