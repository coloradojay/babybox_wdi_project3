class CreateBoxesProductsJoinTable < ActiveRecord::Migration
	create_table :boxes_products, id: false do |t|
		t.belongs_to :box, index: true
		t.belongs_to :product, index: true
	end
end
