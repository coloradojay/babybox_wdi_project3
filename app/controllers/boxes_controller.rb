class BoxesController < ApplicationController
	require_relative "ShopStyleAPI.rb"
	require_relative "GirlsShopStyleAPI.rb"
	
	def new
		@box = Box.new
		@asdf = GirlsShopStyleAPI.new()
	end

	def create
		@box = Box.new(box_params)

		if @box.save
			redirect_to boxes_path
		else
			#if unsuccessful, reset to the new page
			render "new"
		end
	end

	def show
  	@box = Box.find(params[:id])
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

	private
	def box_params
		params.require(:box).permit(:order_number,:status,:user_id,:child_id)
	end

end