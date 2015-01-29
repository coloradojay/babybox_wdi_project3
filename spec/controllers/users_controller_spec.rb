require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	   #  it "has a valid factory" do
    #   expect(FactoryGirl.build(:user)).to be_valid
    # end

 
    		#For the Show page
	describe 'GET #show' do

		it "responds successfully with an HTTP 200 status code" do
			user = FactoryGirl.create(:user)
			get :show, id: user
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end
			#what should happen
		it "renders the show template" do
		 user = FactoryGirl.create(:user)
			get :show, id: user
			expect(response).to render_template("show")
		end
	end 

			#For New
	describe 'GET #new' do 

		it "responds successfully with an HTTP 200 status code" do
			# user = FactoryGirl.create(:user)
			get :new
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end
			#should go to the new.html.erb
		it "renders the new template" do
			# user = FactoryGirl.create(:user) 
			get :new
			expect(response).to render_template("new")
		end 
	end 

			#for Edit
	describe 'GET #edit' do
		it "responds successfully with an HTTP 200 status code" do
		user = FactoryGirl.create(:user)
			get :show, id: user
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end 
			#page should update when edit is complete
		it "renders the show template" do 
		user = FactoryGirl.create(:user)
			get :show, id: user
			expect(response).to be_success("edit")
		end
	end 

	# this is to post new information
	describe 'POST #create' do 
		it "responds successfully with a HTTP 200 status code" do 
		user = FactoryGirl.create(:user)
			post :create, id: user
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end 


		it "renders the create template" do 
			post :create, id: user
			expect(response).to be_success("create")
		end
	end 

	# describe 'PATCH #update' do 
	# 	it "responds successfully with a HTTP 200 status code" do
	# 		patch :update
	# 		expect(response).to be_success
	# 		expect(response).to have_http_status(200)
	# 	end

	# 	it "renders the update template" do 
	# 		patch :update
	# 		expect(response).to be_success("update")
	# 	end
	# end 

	# this is to delete an account
	describe 'DELETE #destroy' do
		it "response successfully with a HTTP 200 status code" do
			delete :destroy
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end 

		# this is what should happen when an account is deleted.
		it "renders the update template" do
			delete :destroy
			expect(response).to have_http_status(200)
		end 
	end   

end