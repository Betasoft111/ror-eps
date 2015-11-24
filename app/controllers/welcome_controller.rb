class WelcomeController < ApplicationController
	#before_filter :current_user
	#before_filter :authenticate_user!

	#################################
	#  	     Render Edit Plan       #
	#################################
	def index
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	    # if @current_user != nil
	       
	       	#################################
			#  	     Check current plan     #
			#################################
			# if @current_user.plan_id != nil
			# 	@plan_details = SubscriptionPlans.find()
			# else
			# 	redirect_to "/choose_plan", :notice => "Please choose a membership plan"
			# end
	    # else
			render :template => "welcome/index", :locals => { :user => @current_user }
		# end
	end


end