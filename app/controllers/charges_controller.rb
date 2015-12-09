require "paypal/recurring"
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
				  :cancel_url   => "http://system.jobkeeper.dk:3000/charges/payment_method",
				  :ipn_url      => "http://system.jobkeeper.dk:3000/charges/payment_ipn",
				  :description  => @plan_details.plan_name,
				  :amount       => @plan_details.plan_price.to_i,
				  :currency     => "USD"
				})

				response = ppr.checkout
				User.where(:id => @current_user.id).update_all(plan_id: @plan_id)
				#:notice => "Membership is updated successfully"
				#redirect_to "/company_home", :notice => "Membership is updated successfully"
				redirect_to response.checkout_url if response.valid?
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
			  :email => params[:stripeEmail],
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
				redirect_to "/company_home", :notice => "Membership is updated successfully"
		  end
			
			#################################
			#         Stripe Ends           #
			################################# 
			rescue Stripe::CardError => e
			  #if error delete user membership
			  User.where(:id => @current_user.id).update_all(plan_id: nil)
			  flash[:error] = e.message
			  redirect_to '/choose_plan'		  

	end

	#################################
	#     IPN Listner For Epay      #
	################################# 
	def payment_ipn
		if params[:txnid] && params[:txnid] != nil && params[:orderid] && params[:orderid] != nil && params[:amount] && params[:amount] != nil
			@plan_details = SubscriptionPlan.where(:plan_price => params[:amount]) #.where(:email => plan_params[:email])
			if @plan_details && @plan_details[0]
				@plan_id = @plan_details[0].id
				User.where(:id => @current_user.id).update_all(plan_id: @plan_id)
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
		@payment_generate = UserPayments.create({
								:payment_method => 'stripe',
								:payment_status => 'paid',
								:user_id => @current_user.id,
								:payment_json => params.to_json
							})
		# if params[:txnid] && params[:txnid] != nil && params[:orderid] && params[:orderid] != nil && params[:amount] && params[:amount] != nil
		# 	@plan_details = SubscriptionPlan.where(:plan_price => params[:amount]) #.where(:email => plan_params[:email])
		# 	if @plan_details && @plan_details[0]
		# 		@plan_id = @plan_details[0].id
		# 		User.where(:id => @current_user.id).update_all(plan_id: @plan_id)
		# 		redirect_to "/company_home", :notice => "Membership is updated successfully"
		# 	end
		# else
		# 	return render :json => {:success => false, :message => "All field are required"}
		# end
	end

	private
		def ipn_params
			params.permit(:payment_method, :payment_status, :user_id, :payment_json)
		end
end
