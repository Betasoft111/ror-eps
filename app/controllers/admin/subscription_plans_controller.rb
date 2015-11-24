class Admin::SubscriptionPlansController < ApplicationController
	before_filter :authenticate_user!

	#################################
	#  	        List Plans          #
	#################################
	def index
		@plans = SubscriptionPlans.all
	end

	#################################
	#  	     Render Create Plan     #
	#################################
	def new
		@subscription_plan = SubscriptionPlans.new
	end

	#################################
	#  	     Create New Plan        #
	#################################
	def create

		@check_plan = SubscriptionPlans.where(:plan_name => plan_params[:plan_name]).where(:plan_price => plan_params[:plan_price]).where(:plan_type => plan_params[:plan_type])
		if @check_plan.empty?
			@subscription_plan = SubscriptionPlans.new(plan_params)
			if @subscription_plan.save
				redirect_to "/admin/subscription_plans", :notice => "New plan is added successfully"
			else
				redirect_to "/admin/subscription_plans/new", :notice => @subscription_plan.errors
			end
		else
			redirect_to "/admin/subscription_plans/new", :notice => "You have already added this plan"
		end
	end

	private

	  def plan_params
	    params.permit(:plan_name, :plan_price, :plan_type)
	  end
end
