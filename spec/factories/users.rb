FactoryGirl.define do
  factory :user do
    first_name "Fred"
    last_name "Rogers"
    email "mrrogers@neighborhood.com"
    ship_address_1 "13 Castle Blvd"
    ship_address_2 ""
    ship_city "Westwood"
    ship_state "MakeBelieve"
    ship_zip 56789
    phone_number "123-456-2152"
    bill_address_1 "13 Castle Blvd"
    bill_address_2 ""
    bill_city "Westwood"
    bill_state "MakeBelieve"
    bill_zip 56789
  end

end
