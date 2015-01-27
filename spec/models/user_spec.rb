require 'rails_helper'

RSpec.describe User, :type => :model do
    it "has a valid factory" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "is invalid without a first name" do
      expect(FactoryGirl.build(:user, first_name: nil)).to be_invalid
    end

    it "is invalid without a last name" do
      expect(FactoryGirl.build(:user, last_name: nil)).to be_invalid
    end

    it "is invalid without an email" do
      expect(FactoryGirl.build(:user, email: nil)).to be_invalid
    end

    it "is invalid with an empty string as the password"
end
