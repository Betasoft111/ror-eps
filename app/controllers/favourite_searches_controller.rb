class FavouriteSearchesController < ApplicationController

	#################################
	#       Save Search Result	    #
	#################################
	
	def create
		favourite_search = FavouriteSearch.new(favourite_params) if current_user
		if favourite_search.save
			redirect_to request.referrer, :notice => "Your search result has been saved successfully"
		else
			redirect_to request.referrer, :notice => "Sorry, please try again"
		end
	end

	private
 	
 	def favourite_params
	    params.permit(:skills, :qualification, :experience, :availability, :user_id)
	end
end