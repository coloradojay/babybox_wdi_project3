module API
  class BoxesAPI < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json

    def index
      boxes = Box.all
      respond_with boxes
    end

    # Show products of one specific box
    def show

      respond_with boxes
    end

    # Show boxes and their products by a category
    def show_category

    end

    # Show boxes and their products by a gender
    def show_gender

    end

    # Show boxes and their products by category and gender
    def show_category_gender

    end
  end
end