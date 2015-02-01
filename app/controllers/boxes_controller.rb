class BoxesController < ApplicationController
	require_relative "ShopStyleAPI.rb"
	require_relative "GirlsShopStyleAPI.rb"
	
	def new
		@box = Box.new
		
		# @asdf = GirlsShopStyleAPI.new()

		@user = current_user
	end

	def show
  	@box = Box.find(params[:id])
	end

	def create
		@box = Box.new

		@box.user = current_user
		@box.order_number = Box.count.to_s
		# @box.status = BOX_STATUSES[0]

		###############
		# Not done yet!
		###############

		# Save products to Products model
		box_params[:products_id].each { |type, id|
			if (type == :shirt_id) && !id.nil?
				product = ShopStyleAPI.product_info(id)
				# include shirt size
				@box.products.new(name: product["name"], price: product["priceLabel"])

			elsif (type == :pant_id) && !id.nil?


			elsif (type == :jacket_id) && !id.nil?
				

			end
		}

				
		if @box.save
			redirect_to boxes_path
		else
			#if unsuccessful, reset to the new page
			render "new"
		end
	end

	def update
		@box = Post.find(params[:id])

		if @box.update_attributes(box_params)
			redirect_to boxes_path
		else
			#if unsuccessful, show to the edit page
			render :update
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to root_path
	end

	def checkout
		@box = Box.find(params[:id])
	end

	private
	def box_params
		params.require(:box).permit(:gender,:shirt_size,:pant_size,:jacket_size,:style, :products_id => [:shirt_id,:pant_id,:jacket_id])
	end

end