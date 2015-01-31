class ProductsController < ApplicationController
	def index
		@products = Product.all
	end 

	def new
		@products = Product.new
	end

end
