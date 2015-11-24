class ChargesController < ApplicationController
	before_filter :authenticate_user!
	
	def new
	end

	def create
	  @plan_id = params[:plan_id]
	  @plan_details = SubscriptionPlans.find(@plan_id)

	  if @plan_details.id != nil
	  	
		  # Amount in cents
		  @amount = @plan_details.plan_price * 100 #500

		  customer = Stripe::Customer.create(
		    :email => params[:stripeEmail],
		    :source  => params[:stripeToken]
		  )

		  charge = Stripe::Charge.create(
		    :customer    => customer.id,
		    :amount      => @amount,
		    :description => 'Rails Stripe customer',
		    :currency    => 'usd'
		  )

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to new_charge_path
		end

	  end
end
