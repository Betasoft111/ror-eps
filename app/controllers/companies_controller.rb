class CompaniesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :current_user
	before_filter :check_membership

	#################################
	#  	        List Plans          #
	#################################
	def index
		params[:page] ||= 1
		@staff_list = CompanyStaff.paginate(:page => params[:page], :per_page => 10)
	end


	def add_staff
			@staff_data = AdminSkills.all
	     	@qualifications = AdminQualifications.all
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
			@allowed_staff = Admin::StaffPlan.find(@current_plan.plan_id)
			if @total_staff.size >= @allowed_staff.no_of_staff
				redirect_to "/company_home", :notice => "plan_is_expired"
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
				redirect_to "/company_home", :notice => "plan_is_expired"
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
		@staff_data1 = AdminSkills.all
	    @qualifications = AdminQualifications.all
		@staff_data = CompanyStaff.find(params[:id])
		@staff_url = '/companies/update/' + @staff_data.id.to_s
		# respond_to do |format|
  #       	format.js
  #   	end
	end

	#################################
	#  		update Compnay staff    #
	#################################
	def update
		if params[:is_private] == "Yes"
			params[:is_private] = 1
		else
		 	params[:is_private] = 0
		end
		CompanyStaff.where(:id => params[:id]).update_all(plan_params)
		redirect_to "/company_home", :notice => "Updated successfully"
	end
	#################################
	#  		Delete Compnay staff    #
	#################################
	def destroy
	    CompanyStaff.find(params[:id]).destroy
	    # @staff_list = CompanyStaff.all
		respond_to do |format|
        	format.html { redirect_to "/company_home", :notice => "Staff Record Deleted successfully" }
        	format.js
    	end
	end

	def upgrade_plan
		@plans = Admin::StaffPlan.all
	end




	private

	  def plan_params
	    params.permit(:first_name, :last_name, :email, :company_id, :skills, :availability, :is_private, :qualification, :experience, :image, :location, :skills)
	 end

end
