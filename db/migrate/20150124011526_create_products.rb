class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :color
      t.string :style
      t.string :image_url
      t.string :description
      t.integer :shirt_size
      t.integer :pants_size
      t.integer :jacket_size
      t.integer :shoe_size
      t.string :sku
      t.string :brand
      t.integer :box_id

      t.timestamps
    end
    
    add_index :products, :box_id
    
  end
end
