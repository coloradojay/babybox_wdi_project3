class AddUsersTable < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :ship_address_1
      t.string :ship_address_2
      t.string :ship_city
      t.string :ship_state
      t.integer :ship_zip
      t.string :phone_number
      t.string :bill_address_1
      t.string :bill_address_2
      t.string :bill_city
      t.string :bill_state
      t.integer :bill_zip
      t.integer :box_id

      t.timestamps
    end
		add_index :users, :box_id
  end
end
