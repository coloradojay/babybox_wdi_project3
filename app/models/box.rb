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
	belongs_to :child

	has_many :products

	validates :user, presence: true
	validates :child, presence: true
	
end
