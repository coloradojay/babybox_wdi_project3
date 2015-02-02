class BoxesController < ApplicationController
	require_relative "ShopStyleAPI.rb"
	require_relative "GirlsShopStyleAPI.rb"
	
	def new
		@box = Box.new
		
		@user = current_user
	end

	def show
  	# @box = Box.find(current_user)
	end

	def create
		@box = Box.new

		@box.user = current_user
		@box.order_number = Box.count.to_s
		@box.status = BOX_STATUSES[0]

		# Save products to @box
		box_params[:products_id].each { |type, id|

			# Save shirt product
			if (type == "shirt_id") && !id.nil?
				product = ShopStyleAPI.product_info(id)

				@box.products.new(name: product["brandedName"], price: product["price"], style: session[:style], image_url: product["image"]["sizes"]["XLarge"]["url"], shirt_size: session[:shirt_size])

			# Save pants product
			elsif (type == "pant_id") && !id.nil?

				product = ShopStyleAPI.product_info(id)

				@box.products.new(name: product["brandedName"], price: product["price"], style: session[:style], image_url: product["image"]["sizes"]["XLarge"]["url"], pants_size: session[:pant_size])

			# Save jacket product
			elsif (type == "jacket_id") && !id.nil?

				product = ShopStyleAPI.product_info(id)

				@box.products.new(name: product["brandedName"], price: product["price"], style: session[:style], image_url: product["image"]["sizes"]["XLarge"]["url"], jacket_size: session[:jacket_size])
			end
		}

				
		if @box.save
			redirect_to root_path
		else
			#if unsuccessful, reset to the new page
			# render "new"
		end
	end

	def update

	end

	def destroy

	end

	def checkout
		# Retrieving recently created box
		@box = Box.where(user_id: current_user).last

		@total_price = 0

		# To calculate total price of box
		@box.products.each do |product|
			if !product.shirt_size.nil?		
			  @shirt = product
			  @total_price += @shirt.price
			elsif !product.jacket_size.nil?
				@jacket = product
				@total_price += @jacket.price
			elsif !product.pants_size.nil?
				@pants = product
				@total_price += @pants.price
			end
		end
	end

	private
	def box_params
		params.require(:box).permit(:products_id => [:shirt_id,:pant_id,:jacket_id])
	end

end