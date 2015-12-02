class SearchController < ApplicationController


	#################################
	#  	        Search method       #
	#################################
	def search     
		@search_results = CompanyStaff.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, company_staffs.* FROM users 
			INNER JOIN company_staffs ON users.id = company_staffs.company_id where company_staffs.skills like '%#{params[:skills]}%' OR company_staffs.availability like '%#{params[:availability]}%' OR company_staffs.experience like '%#{params[:experience]}%' OR company_staffs.qualification like '%#{params[:staff_quf]}%'"
	end
end