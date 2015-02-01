class Box < ActiveRecord::Base
	# Adding constant for box status, allowing for business to update in the future
	BOX_STATUSES = {
		0 => "Processing",
		1 => "Shipped",
		2 => "Delivered",
		3 => "Returned",
		4 => "Unsuccessful"
	}

	belongs_to :user
	has_and_belongs_to_many :products

	validates :user, presence: true

	# Customizing JSON
	def as_json(options={})
		# super(:only => [])
	end
	
end
