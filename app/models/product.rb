class Product < ActiveRecord::Base

	has_and_belongs_to_many :boxes
	has_many :users, through: :boxes


end
