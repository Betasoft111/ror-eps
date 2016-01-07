class SessionsController < ApplicationController

    def register
    	@faqs = Admin::HelpCenter.order('id desc')
    	@user = User.new
	end

	def login
		@faqs = Admin::HelpCenter.order('id desc')
    	@user = User.new
	end

	def create
	  @faqs = Admin::HelpCenter.order('id desc')
	  user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id
	    session[:user_role] = 'user'
	    redirect_to '/company_home', :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid email or password"
	    #render "new"
	    redirect_to "/sign_in", :notice => "Invalid email or password"
	  end
	end

	def destroy
	  session[:user_id] = nil
	  session[:user_role] = nil
	  redirect_to root_url
	end
end
