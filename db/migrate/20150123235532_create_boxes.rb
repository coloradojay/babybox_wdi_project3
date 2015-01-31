class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :order_number
      t.integer :status
      t.belongs_to :user
      t.integer	:user_id
      
			t.timestamps
		end

		add_index :boxes, :user_id

  end
end
