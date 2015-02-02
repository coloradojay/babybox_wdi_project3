# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(first_name: 'Samuel', last_name: 'Jackson', ship_address_1: '123 Bad Mutha Lane', city: 'Los Angeles', ship_state: 'CA', ship_zip: '90026', phone_number: '213-555-1212', email: 'test@test.com', password: 'password')
User.create(first_name: 'Bob', last_name: 'Johnson', ship_address_1: '123 Lovely Meadows Dr', city: 'Los Angeles', ship_state: 'CA', ship_zip: '90027', phone_number: '213-444-1212', email: 'b@b.com', password: 'password')
Product.create(name: 'Red Shirt', color: 'Red', style: '1', shirt_size: '4', sku: '123456789')
Product.create(name: 'Red Pants', color: 'Red', style: '1', pants_size: '4', sku: '987654321')
Product.create(name: 'Red Sweater', color: 'Red', style: '1', jacket_size: '4', sku: '123498765')
Product.create(name: 'Blue Shirt', color: 'Blue', style: '4', shirt_size: '6', sku: '123456785')
Product.create(name: 'Blue Pants', color: 'Blue', style: '4', pants_size: '6', sku: '987654324')
Product.create(name: 'Blue Sweater', color: 'Blue', style: '4', jacket_size: '6', sku: '123498763')