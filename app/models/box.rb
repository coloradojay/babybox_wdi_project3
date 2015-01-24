class Box < ActiveRecord::Base
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

end
