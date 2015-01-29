require 'rails_helper'

RSpec.describe BoxesController, :type => :controller do 

	describe "GET #new" do
		  
	  it "responds successfully with an HTTP 200 status code" do
	    get :new
	    expect(response).to be_success
	    expect(response).to have_http_status(200)
	  end

    it "renders the new template" do
	  	get :new
	  	expect(response).to render_template("new")
  	end

	end

	describe "GET #show" do 

	  it "responds successfully with an HTTP 200 status code" do
	    get :show
	    expect(response).to be_success
	    expect(response).to have_http_status(200)
	  end

		it "renders the :show template" do
			get :show
			expect(response).to render_template("show")
		end

	end 

	describe "GET #update" do

	  it "responds successfully with an HTTP 200 status code" do
	    get :update
	    expect(response).to be_success
	    expect(response).to have_http_status(200)
	  end

		it "renders the :update template" do
			get :update
			expect(response).to render_template("update")
		end


	end

	describe "CREATE #create" do

		it "creates a new box created by a user" do
			get :new
			expect(response).to render_template("new")
		end

	end

end