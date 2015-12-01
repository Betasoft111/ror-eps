class SearchController < ApplicationController


	#################################
	#  	        Search method       #
	#################################
	def search     
		@search_results = CompanyStaff.where("skills LIKE ? OR availability like ? OR experience like ? OR qualification like ?", "%#{params[:skills]}%", "%#{params[:availability]}%" , "%#{params[:experience]}%" , "%#{params[:staff_quf]}%" )
	end





end
