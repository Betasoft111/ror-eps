class CompaniesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :current_user
	before_filter :check_membership

	#################################
	#  	        List Plans          #
	#################################
	def index
		@staff_list = CompanyStaff.all
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
		@staff_plans = CompanyStaff.new
	end



	#################################
	#   Add New Company staff    #
	#################################
	def create
		####################################################
		# Check The Current Plan For Adding Staff Members  #
		####################################################
		@current_plan = UsersStaffPlan.where(:user_id => @current_user.id).first

		##########################
		# Get Total Staff Added  #
		##########################
		@total_staff = CompanyStaff.where(:company_id => @current_user.id)
		if @current_plan && @current_plan != nil
			####################################
			# Get No. Of Staff Allowed To Add  #
			####################################
			@allowed_staff = Admin::StaffPlans.find(@current_plan.plan_id)
			if @total_staff.size >= @allowed_staff.no_of_staff
				redirect_to "/company_home", :notice => "Your plan does not allow you to add new members, please upgrade your plan"
			else
				##########################
				# Add New  Staff Member  #
				##########################
				@check_company = CompanyStaff.where(:email => plan_params[:email])
				if @check_company.empty?
					@check_company = CompanyStaff.new(plan_params)
					if @check_company.save
						redirect_to "/company_home", :notice => "Staff member added successfully"
					else
						redirect_to "/add_staff", :notice => @check_company.errors
					end
				else
					redirect_to "/company_home", :notice => "Staff member already Exists"
				end
			end

		else
			if current_user && current_user.subscription_plan.present? && @current_plan.nil? && current_user.subscription_plan.total_profiles.to_i <= @total_staff.size
				redirect_to "/company_home", :notice => "Your plan does not allow you to add new members, please upgrade your plan"
			else
				##########################
				# Add New  Staff Member  #
				##########################
				@check_company = CompanyStaff.where(:email => plan_params[:email]).first
				if @check_company.blank?
					@check_company = CompanyStaff.new(plan_params)
					if @check_company.save
						redirect_to "/company_home", :notice => "Staff member added successfully"
					else
						redirect_to "/add_staff", :notice => @check_company.errors
					end
				else
					redirect_to "/company_home", :notice => "Staff member already Exists"
				end
			end
		end
			
	end


	#################################
	#  		Edit Compnay staff     #
	#################################
	def edit
		@staff_data = CompanyStaff.find(params[:id])
		@staff_url = '/companies/update/' + @staff_data.id.to_s
	end

	#################################
	#  		update Compnay staff    #
	#################################
	def update
		CompanyStaff.where(:id => params[:id]).update_all(plan_params)
		redirect_to "/company_home", :notice => "Updated successfully"
	end
	#################################
	#  		Delete Compnay staff    #
	#################################
	def destroy
	    CompanyStaff.find(params[:id]).destroy
	    redirect_to "/company_home", :notice => "Staff Record Deleted successfully"
	end


	private

	  def plan_params
	    params.permit(:first_name, :last_name, :email, :company_id, :skills, :availability, :is_private, :qualification, :experience, :image)
	 end

end
