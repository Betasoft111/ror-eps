class CompanyRequestsController < ApplicationController

	def new 
	end

	def show
		@staff_lists = CompanyStaff.all.where(company_id: params[:id]) if params[:id]
	end

	def create
		@request = CompanyRequest.new(request_params)
	  	if @request.save
	    	redirect_to root_url, :notice => "Request Sent Successfully."
	  	else
	  		redirect_to 'company_requests/new', :notice => "Unable To Process Your Request."
	  	end
	end

	private

		def request_params
	    	params.permit(:name, :amount, :total_emp, :selected_emp[], :total_days, :additional)
		end
end