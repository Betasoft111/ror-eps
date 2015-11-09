class WelcomeController < ApplicationController
	before_filter :current_user
	before_filter :authenticate_user!

	def index
		#puts 'user is ' 
		#puts session[:user_id]
		if 
	end


end