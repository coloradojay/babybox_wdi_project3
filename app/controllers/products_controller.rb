class ProductsController < ApplicationController
  require_relative "ShopStyleAPI.rb"
  require_relative "GirlsShopStyleAPI.rb"

  GENDER = ["boy","girl"]
  STYLE = ["athletic","formal","everyday","trendy"]
  SIZE = ["0-3mo","6-9mo","9-12mo","12-18mo","2T","3T","4T","5T"]

	def index

	end 

	def new
		call_api = GirlsShopStyleAPI.new
    @product = Product.new
    @jacket_products  = call_api.jackets_API_data
    @shirt_products   = call_api.shirts_API_data
    @bottom_products  = call_api.bottoms_API_data
	end

  def show
    @products = product_ids_params
    
    @shirt_info = GirlsShopStyleAPI.product_info(@products["shirt_id"]) if !product_ids_params["shirt_id"].nil?
    @jacket_info = GirlsShopStyleAPI.product_info(@products["jacket_id"]) if !product_ids_params["jacket_id"].nil?
    @bottom_info = GirlsShopStyleAPI.product_info(@products["bottom_id"]) if !product_ids_params["bottom_id"].nil?
    
  end

  def filter
    logger.debug("in filter")
  end

  private
  def product_ids_params
    params.fetch("product_ids", {}).permit("shirt_id", "jacket_id", "bottom_id")
  end

end
