require 'rails_helper'

RSpec.describe User, :type => :model do
    it "has a valid factory" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "is invalid without a first name"
    it "is invalid without a last name"
    it "is invalid without an email"
end
