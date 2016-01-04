class Admin::HelpCenterController < ApplicationController
	before_filter :check_admin!

	def index
		@faqs = Admin::HelpCenter.all
	end

	def new
		
	end

	def create
		@added_faq = Admin::HelpCenter.new(help_center_params)
			if @added_faq.save
				redirect_to "/admin/help_center/", :notice => "New FAQ is added successfully!!!"
			else
				@errorMsg = ''
			  	@added_faq.errors.each do |key, message|
			  		@errorMsg += key.to_s
			  		@errorMsg += ' '
			  		@errorMsg += message.to_s
			  	end
				redirect_to "/admin/help_center/new/", :notice => @errorMsg
			end
	end

	def edit
		@faq = Admin::HelpCenter.find(params[:id])
	end	

	def update
		Admin::HelpCenter.where(:id => params[:id]).update_all(question: params[:question], answer: params[:answer])
			redirect_to "/admin/help_center/", :notice => "FAQ updated successfully!!!"		
	end

	def destroy
		Admin::HelpCenter.find(params[:id]).destroy
	   		 redirect_to "/admin/help_center/", :notice => "FAQ Deleted successfully!!!"
	end

private

	  def help_center_params
	    	params.permit(:question, :answer)
	  end	
end
