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
      boxes = Box.last(10).reverse

      products = {}

      prdoucts

      respond_with boxes
    end
  end
end