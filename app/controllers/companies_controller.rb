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
	#   Create New Compnay staff    #
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
	    params.permit(:first_name, :last_name, :email, :company_id, :skills, :availability, :is_private, :qualification, :experience)
	 end

end
