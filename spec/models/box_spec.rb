require 'rails_helper'

RSpec.describe Box, :type => :model do
 	it "is invalid without a user" do
		box = FactoryGirl.build(:box, user_id: nil)
		expect(box).to be_invalid
	end

  it "is invalid without a status" do
  	box = FactoryGirl.build(:box, status: nil)
  	expect(box).to be_invalid
  end

end