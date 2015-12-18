class Admin::RequestsController < ApplicationController


	def index
		@requests = CompanyRequest.all
	end
		
	def edit
		CompanyRequest.where(:id => params[:id]).update_all(is_paid: 1)
		redirect_to '/admin/requests' , :notice => "Payment Approved."
	end
end
