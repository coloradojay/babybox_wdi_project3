class ProductsController < ApplicationController
  require_relative "ShopStyleAPI.rb"
  require_relative "GirlsShopStyleAPI.rb"

	def index

	end 

	def new
		@call_api = GirlsShopStyleAPI.new
    @jacket_products  = @call_api.jackets_API_data
    @shirt_products   = @call_api.shirt_API_data
    @bottom_products  = @call_api.bottoms_API_data
	end

  def show
    logger.debug(params[:number])
    @product = params["shirt_product"]
  end

end
