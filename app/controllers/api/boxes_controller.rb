module API
  class BoxesController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json

    def index
      boxes = Box.all
      respond_with boxes
    end

    # Show products of one specific box
    def show

    end

    def show_first_ten
      product_img_urls = []
      boxes = Box.last(10).reverse

      boxes.each do |box|
        box_products = box.products
        tempArr = []

        box_products.each do |product|
          tempArr.push(product.image_url)
        end
        product_img_urls.push(tempArr)
      end

      respond_with product_img_urls
    end
  end
end