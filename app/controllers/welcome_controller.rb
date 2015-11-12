class WelcomeController < ApplicationController
	before_filter :current_user
	before_filter :authenticate_user!

	def index
		render :template => "welcome/index", :locals => { :user => @current_user }
	end


end