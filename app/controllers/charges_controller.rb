require "paypal/recurring"
require 'json'

class ChargesController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :create]
	before_filter :current_user

	#################################
	#     Render Select Payment     #
	#################################	
	def new
	end

	def create
	  @plan_id = params[:plan_id]	  
	  @plan_details = SubscriptionPlan.find(@plan_id)	  
	  if @plan_details.id != nil
	  		if @plan_details.plan_type == 1
	  			@planname = "Monthly"
	  			@pantype = Time.now + 30.days
	  		elsif @plan_details.plan_type == 2
	  			@pantype = Time.now + 15.days
	  			@planname = "Quaterly"
	  		else  @plan_details.plan_type == 3
	  			@pantype = Time.now + 365.days
	  			@planname = "Yearly"
	  		end

		  @history = UsersPaymentHistory.create({
									:plan_id =>  @plan_details.id,
									:user_id => @current_user.id,
									:purchased_on => Time.new,
									:expired_on => @pantype,
									:plan_name => @planname,
									:plan_type => 'Subscription Plan'
								})
		  @history.save

		end
  		#################################
		#      Check Payment Method     #
		#################################	
	  	if params[:pay_type] && params[:pay_type] == 'paypal'
	  		#################################
			#      Paypal Configuration     #
			#################################	
			if @plan_details.id != nil
			  	PayPal::Recurring.configure do |config|
				  config.sandbox = true
				  config.username = "randhir_api1.betasoftsystems.com"
				  config.password = "N9JPT5UCNRMUXPRK"
				  config.signature = "AFcWxV21C7fd0v3bYYYRCpSSRl31AboldMqHUE-HNrXcXG79zqSK-x33"
				end
				ppr = PayPal::Recurring.new({
				  :return_url   => "http://system.jobkeeper.dk:3000/company_home",
				  :cancel_url   => "http://system.jobkeeper.dk:3000/membership_plans",
				  :ipn_url      => "http://system.jobkeeper.dk:3000/charges/payment_ipn",
				  :description  => @plan_details.plan_name,
				  :amount       => @plan_details.plan_price.to_i,
				  :currency     => "USD"
				})

				response = ppr.checkout
				User.where(:id => @current_user.id).update_all(plan_id: @plan_id)
				@email = UserMailer.payment_email(@current_user, @plan_details.plan_price).deliver				
				redirect_to response.checkout_url, :notice => "Membership is updated successfully" if response.valid?
			end
			#################################
			#           Paypal Ends         #
			#################################
	    elsif @plan_details.id != nil && params[:pay_type] && params[:pay_type] == 'stripe'

			#################################
			#         Stripe Checkout       #
			#################################

			@amount = @plan_details.plan_price.to_i * 100 
			customer = Stripe::Customer.create(
			  :email => @current_user.email,
			  :source  => params[:stripeToken]
			)
			charge = Stripe::Charge.create(
			  :customer    => customer.id,
			  :amount      => @amount.to_i,
			  :description => @plan_details.plan_name,
			  :currency    => 'usd'
			)
				#################################
			    #         Save In Database      #
			    #################################
				User.where(:id => @current_user.id).update_all(plan_id: @plan_id)
				@email = UserMailer.payment_email(@current_user, @plan_details.plan_price).deliver
				# logger.info('*****************  sending email')
				# logger.info(@email)
				# logger.info(@plan_details.plan_price)
				redirect_to "/company_home", :notice => "Membership is updated successfully"
		  end
			
			#################################
			#         Stripe Ends           #
			################################# 
			rescue Stripe::CardError => e
			  #if error delete user membership
			  User.where(:id => @current_user.id).update_all(plan_id: nil)
			  flash[:error] = e.message
			  redirect_to '/membership_plans'		  

	end

	#################################
	#     IPN Listner For Epay      #
	################################# 
	def payment_ipn

#redirect_to "/company_home", :notice => "Membership is updated successfully"


	if params[:txnid] && params[:txnid] != nil && params[:orderid] && params[:orderid] != nil && params[:amount] && params[:amount] != nil
			@plan_details = SubscriptionPlan.where(:plan_price => params[:amount]) #.where(:email => plan_params[:email])
			if @plan_details && @plan_details[0]
				@plan_id = @plan_details[0].id

				#if @plan_details.id != nil
			  		if @plan_details[0].plan_type == 1
			  			@planname = "Monthly"
			  			@pantype = Time.now + 30.days
			  		elsif @plan_details[0].plan_type == 2
			  			@pantype = Time.now + 15.days
			  			@planname = "Quaterly"
			  		else  @plan_details[0].plan_type == 3
			  			@pantype = Time.now + 365.days
			  			@planname = "Yearly"
			  		end

				  @history = UsersPaymentHistory.create({
											:plan_id =>  @plan_id,
											:user_id => @current_user.id,
											:purchased_on => Time.new,
											:expired_on => @pantype,
											:plan_name => @planname,
											:plan_type => 'Subscription Plan'
										})
				  @history.save
				#end  
				
					User.where(:id => @current_user.id).update_all(plan_id: @plan_id)

#					@email = UserMailer.payment_email(@current_user, @plan_details.plan_price).deliver
					#@email = UserMailer.payment_email(@current_user, @plan_details.plan_price).deliver
					

					redirect_to "/company_home", :notice => "Membership is updated successfully"
			end
		else
			return render :json => {:success => false, :message => "All field are required"}
		end
	end

	#################################
	#     IPN Listner For Stripe    #
	################################# 
	def payment_ipn_stripe
		payment_Status = params[:data][:object][:status]
			if payment_Status == 'succeeded'
				@user_email = params[:data][:object][:source][:name]
				@user = User.where(:email => @user_email).first
				@payment_generate = UserPayments.create({
										:payment_method => 'stripe',
										:payment_status => 'paid',
										:user_id => @user.id,
										:payment_json => params[:data][:object].to_json
									})
		 		return render :json => {:success => true, :message => "data updated"}
		 	end
	end

	#################################
	#     IPN Listner For Stripe    #
	################################# 
	def buy_addon_paypal

		  #Get Curretn Plan Allowed Staff
		  @sub_plan = SubscriptionPlan.find(@current_user.plan_id)
		  if @sub_plan != nil
		  	@already_allow = @sub_plan.total_profiles
		  else
		  	@sub_plan = Admin::StaffPlan.find(@current_user.plan_id)
		  	@already_allow = @sub_plan.no_of_staff
		  end
		  ##############################
		  #   Create Paypal Charge     #
		  ##############################
		  @plan_id = params[:plan_id]	  
		  @plan_details = Admin::StaffPlan.find(@plan_id)	  
		  if @plan_details.id != nil
			  @history = UsersPaymentHistory.create({
										:plan_id =>  @plan_details.id,
										:user_id => @current_user.id,
										:purchased_on => Time.new,
										#:expired_on => @pantype,
										:plan_name => @plan_details.plan_name,
										:plan_type => 'Add On Plan'
									})
			  @history.save
			end

			#################################
			#      Paypal Configuration     #
			#################################	
			if @plan_details.id != nil
			  	PayPal::Recurring.configure do |config|
				  config.sandbox = true
				  config.username = "randhir_api1.betasoftsystems.com"
				  config.password = "N9JPT5UCNRMUXPRK"
				  config.signature = "AFcWxV21C7fd0v3bYYYRCpSSRl31AboldMqHUE-HNrXcXG79zqSK-x33"
				end
				ppr = PayPal::Recurring.new({
				  :return_url   => "http://system.jobkeeper.dk:3000/company_home",
				  :cancel_url   => "http://system.jobkeeper.dk:3000/charges/payment_method",
				  :ipn_url      => "http://system.jobkeeper.dk:3000/charges/payment_ipn",
				  :description  => @plan_details.plan_name,
				  :amount       => @plan_details.plan_price.to_i,
				  :currency     => "USD"
				})

				response = ppr.checkout
				#Calculate New Allowed No Of Profiles
				@new_allowed_staff = @plan_details.no_of_staff.to_i + @already_allow.to_i
				UsersStaffPlan.where(:user_id => @current_user.id).update_all(plan_id: @plan_id, no_of_profiles: @new_allowed_staff)
				User.where(:id => @current_user.id).update_all(plan_id: @plan_id)
				@email = UserMailer.payment_email(@current_user, @plan_details.plan_price).deliver				
				redirect_to response.checkout_url, :notice => "Membership is updated successfully" if response.valid?
			end
	end

	#################################
	#     AddOn Plan For Epay    #
	################################# 
	def buy_epay_addon
		#Get Curretn Plan Allowed Staff
		  @sub_plan = SubscriptionPlan.find(@current_user.plan_id)
		  if @sub_plan != nil
		  	@already_allow = @sub_plan.total_profiles
		  else
		  	@sub_plan = Admin::StaffPlan.find(@current_user.plan_id)
		  	@already_allow = @sub_plan.no_of_staff
		  end
		if params[:txnid] && params[:txnid] != nil && params[:orderid] && params[:orderid] != nil && params[:amount] && params[:amount] != nil
			@plan_details = Admin::StaffPlan.where(:plan_price => params[:amount]) #.where(:email => plan_params[:email])
			if @plan_details && @plan_details[0]
				@plan_id = @plan_details[0].id			

				  @history = UsersPaymentHistory.create({
											:plan_id =>  @plan_id,
											:user_id => @current_user.id,
											:purchased_on => Time.new,
											#:expired_on => @pantype,
											:plan_name => @plan_details[0].plan_name,
											:plan_type => 'Addon Plan'
										})
				  @history.save
				#end  
				
					#User.where(:id => @current_user.id).update_all(plan_id: @plan_id)
					@new_allowed_staff = @plan_details.no_of_staff.to_i + @current_user.
					UsersStaffPlan.where(:user_id => @current_user.id).update_all(plan_id: @plan_id, no_of_profiles: @new_allowed_staff)
					@email = UserMailer.payment_email(@current_user, @plan_details.plan_price).deliver
					redirect_to "/company_home", :notice => "Membership is updated successfully"
			end
		else
			return render :json => {:success => false, :message => "All field are required"}
		end
	end

	private
		def ipn_params
			params.permit(:payment_method, :payment_status, :user_id, :payment_json)
		end
end
