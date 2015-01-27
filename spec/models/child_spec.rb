require 'rails_helper'

RSpec.describe Child, :type => :model do
   it "has a valid factory"do 
   	expect(FactoryGirl.build(:child)).to be_valid
  end

   it "is invalid without a valid name" do 
   	child = FactoryGirl.build(:child, name: nil)
      expect(child).to be_invalid
    end

  # it "is invalid without a valid age in years" do 
  # 	FactoryGirl.create(:child)
  # 	child = FactoryGirl.build(:child, age_yrs: nil, age_months: 36)
  # 		expect(child).to be_invalid
  # 	end

  # it "is invalid without a valid age in months" do
  # 	FactoryGirl.create(:child)
  # 	child = FactoryGirl.build(:child, age_yrs: 1, age_months: nil)
  # 		expect(child).to be_invalid
  # 	end


  it "is invalid without a valid gender" do
  	child = FactoryGirl.build(:child, gender: nil)
  		expect(child).to be_invalid
  	end

  it "is invalid without a valid style" do
  	child = FactoryGirl.build(:child, style: nil)
  		expect = FactoryGirl.build(:child)
  	end

  it "is invalid without a shirt-size" do
  	child = FactoryGirl.build(:child, shirt_size: nil)
  		expect = FactoryGirl.build(:child)
  	end

  it "it is invalid without a pant-size" do 
  	child = FactoryGirl.build(:child, pant_size: nil)
  		expect = FactoryGirl.build(:child)
  	end 

  it "is invalid without a jacket-size" do
  	child = FactoryGirl.build(:child, jacket_size: nil)
  		expect = FactoryGirl.build(:child)
  	end

  it "is invalid without a shoe-size" do 
  	child = FactoryGirl.build(:child, shoe_size: nil)
  		expect = FactoryGirl.build(:child)
  	end
end 
