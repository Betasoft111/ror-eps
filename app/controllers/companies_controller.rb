class CompaniesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :current_user

	#################################
	#  	        List Plans          #
	#################################
	def index
		@plans = CompanyStaff.all
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
	#  Create New Compnay         #
	#################################
	def create

		@check_company = CompanyStaff.where(:email => plan_params[:email])
		if @check_company.empty?
			@check_company = CompanyStaff.new(plan_params)
			if @check_company.save
				redirect_to "/company_home", :notice => "Company added successfully"
			else
				redirect_to "/company_home", :notice => @check_company.errors
			end
		else
			redirect_to "/company_home", :notice => "Company  already Exists"
		end
	end




	private

	  def plan_params
	    params.permit(:first_name, :last_name, :email, :company_id, :skills, :availability, :is_private, :qualification, :experience)
	 end

end
