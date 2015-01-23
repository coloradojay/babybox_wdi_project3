class User < ActiveRecord::Base

	has_many :children
	has_many :boxes
	has_many :products, through: :boxes
	
end
