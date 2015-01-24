class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.integer :age_yrs
      t.integer :age_months
      t.string :gender
      t.integer :style
      t.integer :shirt_size
      t.integer :pant_size
      t.integer :jacket_size
      t.integer :shoe_size

      t.timestamps
    end
  end
end
