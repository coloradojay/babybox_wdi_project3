class ProductsController < ApplicationController
  require_relative "ShopStyleAPI.rb"
  require_relative "GirlsShopStyleAPI.rb"

	def index

	end 

	def new
    session[:shirt_size]   = filters_params[:shirt_size]
    session[:jacket_size]  = filters_params[:jacket_size]
    session[:pant_size]    = filters_params[:pant_size]
    session[:price]        = filters_params[:price]
    session[:gender]       = filters_params[:gender]
    session[:style]        = filters_params[:style]
    
		# call_api = GirlsShopStyleAPI.new
    logger.debug("shirt filter_params #{filters_params[:shirt_size]}")
    # Athletic 
    call_api = GirlsShopStyleAPI.new(0,filters_params[:shirt_size],filters_params[:pants_size],filters_params[:jacket_size],"female",25)

    logger.debug("call_api style: #{call_api.style}")
    logger.debug("shirt size: #{call_api.shirt_size}")
    # logger.debug("pant_size: #{call_api.pant_size}")
    logger.debug("price: #{call_api.price}")

    # call_api = GirlsShopStyleAPI.new(params[:style],params[:shirt_size],params[:pants_size],params[:jacket_size],params[:gender],params[:price]) if params[:gender] == "girl"
    # call_api = ShopStyleAPI.new(params[:style],params[:shirt_size],params[:pants_size],params[:jacket_size],params[:gender],params[:price]) if params[:gender] == "boy"

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

  end

  private
  def product_ids_params
    params.fetch("product_ids", {}).permit("shirt_id", "jacket_id", "bottom_id")
  end

  def filters_params
    params.require(:product).permit(:shirt_size, :pants_size, :jacket_size, :gender, :style, :price)
  end

end
