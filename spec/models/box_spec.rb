require 'rails_helper'

RSpec.describe Box, :type => :model do
 	it "is invalid without a user" do
		box = FactoryGirl.build(:box, user_id: nil)
		expect(box).to be_invalid
	end

  it "is invalid without a child" do
  	box = FactoryGirl.build(:box, child_id: nil)
  	expect(box).to be_invalid
  end

  it "is invalid without an order number" do
  	box = FactoryGirl.build(:box, order_number: nil)
  	expect(box).to be_invalid
  end

  it "is invalid without a status" do
  	box = FactoryGirl.build(:box, status: nil)
  	expect(box).to be_invalid
  end

end