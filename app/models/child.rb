	class Child < ActiveRecord::Base
	belongs_to :user
	has_many :boxes

	validates :name, presence: true
	validates :gender, presence: true 	

end
