class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :order_number
      t.integer :status
      t.belongs_to :user
      t.belongs_to :product
      t.integer	:user_id
      t.integer :product_id


			t.timestamps
		end

		add_index :boxes, :user_id
    add_index :boxes, :product_id


  end
end
