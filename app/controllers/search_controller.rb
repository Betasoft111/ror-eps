class SearchController < ApplicationController
		#before_filter :authenticate_user!
		before_filter :current_user

	#################################
	#  	        Search method       #
	#################################
	def search     
		@faqs = Admin::HelpCenter.order('id desc')
		@staff_data = AdminSkills.all
		@qualifications = AdminQualifications.all
		@search_results = nil #CompanyStaff.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, company_staffs.* FROM users INNER JOIN company_staffs ON users.id = company_staffs.company_id where company_staffs.skills like '%#{params[:skills]}%' AND company_staffs.availability like '%#{params[:availability]}%' AND company_staffs.experience like '%#{params[:experience]}%' AND company_staffs.qualification like '%#{params[:staff_quf]}%'"
		@max_price = CompanyStaff.maximum("staff_price")
		@min_price = CompanyStaff.minimum("staff_price")
		#@search_results = CompanyStaff.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, company_staffs.* FROM users INNER JOIN company_staffs ON users.id = company_staffs.company_id where company_staffs .is_private = 0 and company_staffs.skills like '%#{params[:skills]}%' AND company_staffs.availability like '%#{params[:availability]}%' AND company_staffs.experience like '%#{params[:experience]}%' AND company_staffs.qualification like '%#{params[:staff_quf]}%'"
	end

	def search_json     
	@search_results = CompanyStaff.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, company_staffs.* FROM users INNER JOIN company_staffs ON users.id = company_staffs.company_id where company_staffs.skills like '%#{params[:skills]}%' AND company_staffs.availability like '%#{params[:availability]}%' AND company_staffs.experience like '%#{params[:experience]}%' AND company_staffs.qualification like '%#{params[:staff_quf]}%' limit #{params[:start]}, #{params[:end]}"

	@total = CompanyStaff.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, company_staffs.* FROM users INNER JOIN company_staffs ON users.id = company_staffs.company_id where company_staffs.skills like '%#{params[:skills]}%' AND company_staffs.availability like '%#{params[:availability]}%' AND company_staffs.experience like '%#{params[:experience]}%' AND company_staffs.qualification like '%#{params[:staff_quf]}%'"

		if @total != nil
			@total_pages = @total.length
		else
			@total_pages = 0
		end
		render :json => {:data => @search_results, :total_pages => @total_pages}
		#render :json => {:success => false, :data => "Required fields are missing "}  
	end
	#################################
	#  	Details Of Select Member    #
	#################################
	def show_details
		@faqs = Admin::HelpCenter.order('id desc')
		@user_detail = CompanyStaff.find(params[:id])
	end


	##################################
	#       Filter Staff Ajax        #
	##################################
	def staff_ajax_filter
		#logger.info(params)
		@search_results = CompanyStaff.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, company_staffs.* FROM users INNER JOIN company_staffs ON users.id = company_staffs.company_id where company_staffs.skills like '%#{params[:skills]}%' AND company_staffs.availability like '%#{params[:availability]}%' AND company_staffs.experience like '%#{params[:experience]}%' AND company_staffs.qualification like '%#{params[:staff_quf]}%' limit #{params[:start]}, #{params[:end]}"

		@total = CompanyStaff.find_by_sql "SELECT users.first_name as company_fn, users.last_name as company_ln, company_staffs.* FROM users INNER JOIN company_staffs ON users.id = company_staffs.company_id where company_staffs.skills like '%#{params[:skills]}%' AND company_staffs.availability like '%#{params[:availability]}%' AND company_staffs.experience like '%#{params[:experience]}%' AND company_staffs.qualification like '%#{params[:staff_quf]}%'"

		#render json: @search_results
		if @total != nil
			@total_pages = @total.length
		else
			@total_pages = 0
		end
		render :json => {:data => @search_results, :total_pages => @total_pages}
	end

	def new

	end
end