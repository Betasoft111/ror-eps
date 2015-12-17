class CompanyRequestsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :current_user
	before_filter :check_membership

	#################################
	#   Show the Hiring Request     #
	################################# 
	def index
		if @current_user.user_type == 1
			redirect_to '/not_authorized', :notice => "You are not authorized to view this page."
		else
			params[:page] ||= 1
			@requests = CompanyRequest.where(:request_to => @current_user.id).paginate(:page => params[:page], :per_page => 10)
		end
	end

	def new 
	end

	def show
		puts params[:id]
		if params[:id] == @current_user.id
			redirect_to '/not_authorized', :notice => "You can't make request for you own employees"
		else
			@staff_lists = CompanyStaff.all.where(company_id: params[:id]) if params[:id]
		end
	end

	#######################################
	#   Create New Request To Company     #
	####################################### 
	def create
		@request_by = User.find(params[:company_id])
		@request = CompanyRequest.new({
					:name => params[:name],
					:amount => params[:amount] ,
					:total_emp => params[:total_emp],
					:selected_emp => params[:selected_emp],
					:total_days => params[:total_days],
					:additional => params[:additional],
					:request_by => @current_user.id,
					:request_to => @request_by.id,
					:is_rejected => 0,
					:is_approved => 0,
					:is_paid => 0,
					:user_emailTo => @request_by.email,
					:user_emailBy => @current_user.email
					})
	  	if @request.save
	    	redirect_to root_url, :notice => "Request Sent Successfully."
	  	else
	  		redirect_to 'company_requests/new', :notice => "Unable To Process Your Request."
	  	end
	end

	#######################################
	#   Create New Request To Company     #
	#######################################
	def request_details
		@request_details = CompanyRequest.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, users.email as company_email, company_requests.* FROM users INNER JOIN company_requests ON users.id = company_requests.request_by where company_requests.request_to = '#{@current_user.id}'"
		#CompanyRequest.find(params[:id])
	end

	############################
	#   Approve The Reuest     #
	############################
	def approve
		CompanyRequest.where(:request_to => @current_user.id).update_all(is_approved: 1)
		redirect_to '/hiring_requests', :notice => "Request is approved"
	end

	############################
	#   Reject The Request     #
	############################
	def reject
		CompanyRequest.where(:request_to => @current_user.id).update_all(is_rejected: 1)
		redirect_to '/hiring_requests', :notice => "Request is rejected"
	end

	#function to show my requests
	def myrequests
		if @current_user.user_type == 2
			redirect_to '/not_authorized', :notice => "You are not authorized to view this page."
		else
			@request_by_details = CompanyRequest.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, users.email as company_email, company_requests.* FROM users INNER JOIN company_requests ON users.id = company_requests.request_by where company_requests.request_by = '#{@current_user.id}'"
		end

	end

	private

		def request_params
	    	params.permit(:name, :amount, :total_emp, :selected_emp, :total_days, :additional, :request_by, :request_to, :is_rejected, :is_approved, :is_paid, :user_emailTo, :user_emailBy)
		end
end