class Admin::StaffPlansController < ApplicationController
	before_filter :check_admin!

	#################################
	#  	        List Plans          #
	#################################
	def index
		@plans = Admin::StaffPlan.all
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
		@staff_plans = Admin::StaffPlan.new
	end



	#################################
	#  Create New staff Plan        #
	#################################
	def create

		@check_plan = Admin::StaffPlan.where(:plan_name => plan_params[:plan_name]).where(:no_of_staff => plan_params[:no_of_staff]).where(:plan_price => plan_params[:plan_price])
		if @check_plan.empty?
			@StaffPlans = Admin::StaffPlan.new(plan_params)
			if @StaffPlans.save
				redirect_to "/admin/staff_plans", :notice => "New Staff plan is added successfully"
			else
				redirect_to "/admin/staff_plans/new", :notice => @StaffPlans.errors
			end
		else
			redirect_to "/admin/staff_plans/new", :notice => "You have already added this Staff plan"
		end
	end


	#################################
	#  	     Render Edit staff Plan #
	#################################
	def edit
		@staff_plan = Admin::StaffPlan.find(params[:id])
		@staff_path = '/admin/staff_plans/update/' + @staff_plan.id.to_s
	end

	#################################
	#     	   Update staff Plan    #
	#################################
	def update
		Admin::StaffPlan.where(:id => params[:id]).update_all(plan_name: params[:plan_name], no_of_staff: params[:no_of_staff], plan_price: params[:plan_price])
		redirect_to "/admin/staff_plans", :notice => "Staff Plan is updated successfully"
	end

	#################################
	#     	   Delete staff Plan    #
	#################################

	def destroy
	    Admin::StaffPlan.find(params[:id]).destroy
	    redirect_to "/admin/staff_plans", :notice => "Staff Record Deleted successfully"
	end





	private

	  def plan_params
	    params.permit(:plan_name, :no_of_staff, :plan_price)
	 end


end
