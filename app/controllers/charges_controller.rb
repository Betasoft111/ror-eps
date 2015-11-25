PayPal::SDK.load('config/paypal.yml',  ENV['RACK_ENV'] || 'development')
class ChargesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :current_user

	#################################
	#     Render Select Payment     #
	#################################	
	def new
	end

	def create
	  @plan_id = params[:plan_id]
	  @plan_details = SubscriptionPlans.find(@plan_id)

	  if @plan_details.id != nil
	  	
		  # Amount in cents
		  @amount = @plan_details.plan_price.to_i * 100 #500
		  puts "amount"
		  puts @amount.to_i
		  customer = Stripe::Customer.create(
		    :email => params[:stripeEmail],
		    :source  => params[:stripeToken]
		  )
		 customer.inspect
		  charge = Stripe::Charge.create(
		    :customer    => customer.id,
		    :amount      => @amount.to_i,
		    :description => @plan_details.plan_name,
		    :currency    => 'usd'
		  )
		  #Save in database
		  User.where(:id => @current_user.id).update_all(plan_id: @plan_id)
		  redirect_to "/company_home", :notice => "Membership is updated successfully"
	  end
		 
		rescue Stripe::CardError => e
		  #if error delete user membership
		  User.where(:id => @current_user.id).update_all(plan_id: nil)
		  flash[:error] = e.message
		  redirect_to '/choose_plan'		  

	end


end
