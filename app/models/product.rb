class Product < ActiveRecord::Base
	has_many :boxes
	has_many :users, through: :boxes
end
