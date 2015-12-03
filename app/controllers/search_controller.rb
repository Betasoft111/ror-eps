class SearchController < ApplicationController


	#################################
	#  	        Search method       #
	#################################
	def search     
		@search_results = CompanyStaff.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, company_staffs.* FROM users 
			INNER JOIN company_staffs ON users.id = company_staffs.company_id where company_staffs.skills like '%#{params[:skills]}%' AND company_staffs.availability like '%#{params[:availability]}%' AND company_staffs.experience like '%#{params[:experience]}%' AND company_staffs.qualification like '%#{params[:staff_quf]}%'"
	end


	def show_details
		

	end
end