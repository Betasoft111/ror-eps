class Admin::RequestsController < ApplicationController


	def index
		@requests = CompanyRequest.all
	end
end
