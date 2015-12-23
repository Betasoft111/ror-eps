class SessionsController < ApplicationController

    def register
    	@user = User.new
	end

	def login
    	@user = User.new
	end

	def create
	  user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id
	    session[:user_role] = 'user'
	    redirect_to '/company_home', :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
	end

	def destroy
	  session[:user_id] = nil
	  session[:user_role] = nil
	  redirect_to root_url
	end
end
