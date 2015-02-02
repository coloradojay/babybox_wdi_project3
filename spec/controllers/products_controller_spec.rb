require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
	describe "GET #filter" do
		  
	  it "responds successfully with an HTTP 200 status code" do
	    get :filter
	    expect(response).to be_success
	    expect(response).to have_http_status(200)
	  end


    it "renders the new template" do
	  	get :filter
	  	expect(response).to render_template("filter")
  	end
	end
end
