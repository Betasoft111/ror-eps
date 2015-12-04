class Admin::SubscriptionPlansController < ApplicationController
	before_filter :check_admin!

	#################################
	#  	        List Plans          #
	#################################
	def index
		@plans = SubscriptionPlan.all
	end

	#################################
	#  	        Show Plan           #
	#################################
	def show
  	end

	#################################
	#  	     Render Create Plan     #
	#################################
	def new
		@subscription_plan = SubscriptionPlan.new
	end

	#################################
	#  	     Create New Plan        #
	#################################
	def create

		@check_plan = SubscriptionPlan.where(:plan_name => plan_params[:plan_name]).where(:plan_price => plan_params[:plan_price]).where(:plan_type => plan_params[:plan_type])
		if @check_plan.empty?
			@subscription_plan = SubscriptionPlan.new(plan_params)
			if @subscription_plan.save
				redirect_to "/admin/subscription_plans", :notice => "New plan is added successfully"
			else
				redirect_to "/admin/subscription_plans/new", :notice => @subscription_plan.errors
			end
		else
			redirect_to "/admin/subscription_plans/new", :notice => "You have already added this plan"
		end
	end

	#################################
	#  	     Render Edit Plan       #
	#################################
	def edit
		@subscription_plan = SubscriptionPlan.find(params[:id])
		@subscription_path = '/admin/subscription_plans/update/' + @subscription_plan.id.to_s
	end

	#################################
	#     	   Update Plan          #
	#################################
	def update
		SubscriptionPlan.where(:id => params[:id]).update_all(plan_name: params[:plan_name], plan_price: params[:plan_price], plan_type: params[:plan_type], total_profiles: params[:total_profiles])
		redirect_to "/admin/subscription_plans", :notice => "Plan is updated successfully"
	end

	def destroy
	    # @subscription_plan.destroy
	    SubscriptionPlan.find(params[:id]).destroy
	    redirect_to "/admin/subscription_plans", :notice => "Record Deleted successfully"
	end

	private

	  def plan_params
	    params.permit(:plan_name, :plan_price, :plan_type, :total_profiles)
	  end
end
