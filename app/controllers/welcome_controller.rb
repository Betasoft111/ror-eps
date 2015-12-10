class WelcomeController < ApplicationController
	#before_filter :current_user
	#before_filter :authenticate_user!
	before_filter :check_membership

	#################################
	#  	     Render Edit Plan       #
	#################################
	def index
		
			# if @current_user.plan_id != nil
			# 	@plan_details = SubscriptionPlan.find()
			# else
			# 	redirect_to "/choose_plan", :notice => "Please choose a membership plan"
			# end
	     #else
	     	@staff_data = CompanyStaff.all
			render :template => "welcome/index", :locals => { :user => @current_user }

		 #end
	end


end