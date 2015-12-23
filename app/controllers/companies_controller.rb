class CompaniesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :current_user
	before_filter :check_membership

	#################################
	#  	        List Plans          #
	#################################
	def index
		# if params[:txnid] && params[:txnid] != nil && params[:orderid] && params[:orderid] != nil && params[:amount] && params[:amount] != nil
		# 	@plan_details = SubscriptionPlan.where(:plan_price => params[:amount]) #.where(:email => plan_params[:email])
		# 	if @plan_details && @plan_details[0]
		# 		@plan_id = @plan_details[0].id
		# 		User.where(:id => @current_user.id).update_all(plan_id: @plan_id)
		# 		redirect_to "/company_home", :notice => "Membership is updated successfully"
		# 	end
		# else
		# 	#return render :json => {:success => false, :message => "All field are required"}
		# end
		params[:page] ||= 1
		@staff_list = CompanyStaff.where(:company_id => @current_user.id).paginate(:page => params[:page], :per_page => 10)
	end


	def add_staff
		@staff_data = AdminSkills.all
	    @qualifications = AdminQualifications.all
	end

	#################################
	#  	        Show Plan           #
	#################################
	def show
  	end

	#################################
	#  	     Render Add Staff       #
	#################################
	def new
		@staff_plans = CompanyStaff.new
	end


	def payment_his
		@userpaymentdetails = UsersPaymentHistory.where(:user_id => @current_user.id )
	end




	#################################
	#   Add New Company staff    #
	#################################
	def create
		####################################################
		# Check The Current Plan For Adding Staff Members  #
		####################################################
		@current_plan = UsersStaffPlan.where(:user_id => @current_user.id).first

		
		##########################
		# Get Total Staff Added  #
		##########################
		@total_staff = CompanyStaff.where(:company_id => @current_user.id)
		if @current_plan && @current_plan != nil
			####################################
			# Get No. Of Staff Allowed To Add  #
			####################################
			@allowed_staff = Admin::StaffPlan.find(@current_plan.plan_id)
			if @total_staff.size >= @current_plan.no_of_profiles.to_i 
				redirect_to "/company_home", :notice => "plan_is_expired"
			else
				##########################
				# Add New  Staff Member  #
				##########################
				@check_company = CompanyStaff.where(:email => plan_params[:email])
				if @check_company.empty?
					@check_company = CompanyStaff.new(plan_params)
					if @check_company.save
						redirect_to "/company_home", :notice => "Staff member added successfully"
					else
						redirect_to "/add_staff", :notice => @check_company.errors
					end
				else
					redirect_to "/company_home", :notice => "Staff member already Exists"
				end
			end

		else
			if @current_user && @current_user.subscription_plan.present? && @current_plan.nil? && @current_user.subscription_plan.total_profiles.to_i <= @total_staff.size
				redirect_to "/company_home", :notice => "plan_is_expired"
			else
				##########################
				# Add New  Staff Member  #
				##########################
				@check_company = CompanyStaff.where(:email => plan_params[:email]).first
				if @check_company.blank?
					@check_company = CompanyStaff.new(plan_params)
					if @check_company.save
						redirect_to "/company_home", :notice => "Staff member added successfully"
					else
						redirect_to "/add_staff", :notice => @check_company.errors
					end
				else
					redirect_to "/company_home", :notice => "Staff member already Exists"
				end
			end
		end
			
	end


	#################################
	#  		Edit Compnay staff     #
	#################################
	def edit
		@staff_data1 = AdminSkills.all
	    @qualifications = AdminQualifications.all
		@staff_data = CompanyStaff.find(params[:id])
		@staff_url = '/companies/update/' + @staff_data.id.to_s
		# respond_to do |format|
  #       	format.js
  #   	end
	end

	#################################
	#  		update Compnay staff    #
	#################################
	def update
			logger.info("-------------------------------");
			logger.info(plan_params);

		if params[:is_private] == "Yes"
			params[:is_private] = 1
		else
		 	params[:is_private] = 0
		end
		@user = CompanyStaff.find(params[:id])
    	@user.update_attribute(:image, params[:image])
		CompanyStaff.where(:id => params[:id]).update_all(:first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :skills => params[:skills], :availability => params[:availability], :is_private => params[:is_private], :qualification => params[:qualification], :experience => params[:experience], :location => params[:location], :availability_to => params[:availability_to], :availability_from => params[:availability_from])
		redirect_to "/company_home", :notice => "Updated successfully"
	end
	#################################
	#  		Delete Compnay staff    #
	#################################
	def destroy
	    CompanyStaff.find(params[:id]).destroy
	    # @staff_list = CompanyStaff.all
		respond_to do |format|
        	format.html { redirect_to "/company_home", :notice => "Staff Record Deleted successfully" }
        	format.js
    	end
	end

	#################################
	#  		Render Upgrade Plan     #
	#################################
	def upgrade_plan
		@plans = Admin::StaffPlan.all
	end

	#################################
	#  		Upgrade AddOn Plans     #
	#################################
	def upgrade_staff_plan
		@plan_id = params[:plan_id]
	  	@plan_details = Admin::StaffPlan.find(@plan_id)
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
									:plan_type => 'StaffPlan'
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
				  :cancel_url   => "http://system.jobkeeper.dk:3000/charges/payment_method",
				  :ipn_url      => "http://system.jobkeeper.dk:3000/charges/payment_ipn",
				  :description  => @plan_details.plan_name,
				  :amount       => @plan_details.plan_price.to_i,
				  :currency     => "USD"
				})

				response = ppr.checkout
				@current_sub_plan = UsersStaffPlan.where(:user_id => @current_user.id)#.update_all(plan_id: @plan_id)
				if @current_sub_plan.empty?
					UsersStaffPlan.create({
			          :user_id=> @current_user.id,
			          :plan_id=> @plan_id
			        })
			        #redirect_to "/company_home", :notice => "Membership is updated successfully"
				else
					@new_profiles = @current_sub_plan[0].no_of_profiles.to_i + @plan_details.no_of_staff.to_i
					 UsersStaffPlan.where(:user_id => @current_user.id).update_all(plan_id: @plan_id, no_of_profiles: @new_profiles)
					 #redirect_to "/company_home", :notice => "Membership is updated successfully"
				end
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
				@current_sub_plan = UsersStaffPlan.where(:user_id => @current_user.id)#.update_all(plan_id: @plan_id)
				if @current_sub_plan.empty?
					UsersStaffPlan.create({
			          :user_id=> @current_user.id,
			          :plan_id=> @plan_id
			        })
			        redirect_to "/company_home", :notice => "Membership is updated successfully"
				else
					@new_profiles = @current_sub_plan[0].no_of_profiles.to_i + @plan_details.no_of_staff.to_i
					 UsersStaffPlan.where(:user_id => @current_user.id).update_all(plan_id: @plan_id, no_of_profiles: @new_profiles)
					 @email = UserMailer.payment_email(@current_user, @plan_details.plan_price.to_i).deliver
					 redirect_to "/company_home", :notice => "Membership is updated successfully"
				end
				
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

	def no_access
	end

	private

	  def plan_params
	    params.permit(:first_name, :last_name, :email, :company_id, :skills, :availability, :is_private, :qualification, :experience, :image, :location, :skills, :availability_to, :availability_from)
	 end

end
