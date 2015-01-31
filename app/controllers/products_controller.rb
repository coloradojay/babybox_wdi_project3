class ProductsController < ApplicationController
  require_relative "ShopStyleAPI.rb"
  require_relative "GirlsShopStyleAPI.rb"

  def filter

  end

	def new
    # Store API object that calls the API
    @call_api

    # if(products_params[:gender] == "male")
      # @call_api = ShopStyleAPI.new(
      #                 products_params[:style],
      #                 products_params[:shirt_size],
      #                 products_params[:pants_size],
      #                 products_params[:jacket_size],
      #                 products_params[:gender],
      #                 products_params[:price])
      @call_api = ShopStyleAPI.new

      #<%= image_tag thing["image"]["sizes"]["XLarge"]["url"] %>
    # else
      # @call_api = GirlsShopStyleAPI.new(
      #                 products_params[:style],
      #                 products_params[:shirt_size],
      #                 products_params[:pants_size],
      #                 products_params[:jacket_size],
      #                 products_params[:gender],
      #                 products_params[:price])
      # @call_api = GirlsShopStyleAPI.new
    # end

	end 

  def create

  end

  def checkout

  end

  private
  def products_params
    params.require(:products).require(:style, :gender, :pants_size, :shirt_size, :jacket_size, :price)
  end

end
