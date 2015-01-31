class BoxesController < ApplicationController
	require_relative "ShopStyleAPI.rb"
	require_relative "GirlsShopStyleAPI.rb"
	
	def new
		@box = Box.new
		@user = current_user
	end

	def show
  	@box = Box.find(params[:id])
	end

	def create
		@box = Box.new(box_params)
		@box.user = current_user
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
		params.require(:box).permit(:order_number,:status,:user_id,:child_id,:gender,:shirt_size,:pant_size,:jacket_size,:style)
	end

end