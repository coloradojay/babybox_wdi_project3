class Box < ActiveRecord::Base

	belongs_to :user
	has_and_belongs_to_many :products

	validates :user, presence: true

	# Customizing JSON
	def as_json(options={})
		super(:only => [:order_number, :id])
	end
	
end
