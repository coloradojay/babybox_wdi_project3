class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :order_number
      t.integer :status
      t.belongs_to :user
      t.integer	:user_id
			t.integer	:child_id

			t.timestamps
		end

		add_index :box, :user_id
		add_index :boxes, :child_id

  end
end
