class WelcomeController < ApplicationController
	#before_filter :current_user
	#before_filter :authenticate_user!
	before_filter :check_membership

	################
	#  	Home Page  #
	################
	def index
		
			# if @current_user.plan_id != nil
			# 	@plan_details = SubscriptionPlan.find()
			# else
			# 	redirect_to "/choose_plan", :notice => "Please choose a membership plan"
			# end
	     #else
	     	@staff_data = AdminSkills.all
	     	@qualifications = AdminQualifications.all
	     	@faqs = Admin::HelpCenter.all
			render :template => "welcome/index", :locals => { :user => @current_user }

		 #end
	end

	#################
	#  	About Page  #
	#################
	def about
		@page_details = Admin::GeneralPages.where(:page_name => 'about').first
	end

	##################
	#  	Contact Page #
	##################
	def contact
		@page_details = Admin::GeneralPages.where(:page_name => 'contact').first
	end

	##################
	#  	 Help  Page  #
	##################
	def help
		@faqs = Admin::HelpCenter.all
	end

	######################
	#  	 Artile Details  #
	######################
	def article_details
		@faq = Admin::HelpCenter.find(params[:id])
	end
end