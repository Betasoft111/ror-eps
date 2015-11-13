class Admin::SubscriptionPlansController < ApplicationController
	before_filter :authenticate_user!

	def index
	end

	def new
		@subscription_plan = Admin::SubscriptionPlansController.new
	end

	def create
		# @new_plan = Admin::SubscriptionPlansController.create(plan_params)

		# if @new_plan && @new_plan.id != '' && @new_plan.id != nil
		# else
		# 	flash.now.alert = "Invalid email or password"
	 #    	render "new"
		# end

		@subscription_plan = Admin::SubscriptionPlansController.new(plan_params)

	    respond_to do |format|
	      if @subscription_plan.save
	        format.html { redirect_to @subscription_plan, notice: 'Plan was successfully created.' }
	        format.json { render action: 'index', status: :created, location: @subscription_plan }
	      else
	        format.html { render action: 'new' }
	        format.json { render json: @subscription_plan.errors, status: :unprocessable_entity }
	      end
	    end
	end

	private

	  def plan_params
	    params.require(:subscription_plan).permit(:plan_name, :plan_price)
	  end
end
