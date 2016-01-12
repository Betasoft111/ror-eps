class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:choose_plan, :payment_method]
    #before_action :authenticate	
	
	#################################
	#  		 Render New User	    #
	#################################
	def new
	  @user = User.new
	end

	#################################
	#  		 Create New User	    #
	#################################
	def create
	  @user = User.new(user_params)
	  if @user.save
	    session[:user_id] = @user.id
	    redirect_to "/company_home", :notice => "Signed up!"
	  else
	  	@errorMsg = ''
	  	@user.errors.each do |key, message|
	  		@errorMsg += key.to_s
	  		@errorMsg += ' '
	  		@errorMsg += message.to_s
	  	end
	    redirect_to "/join", :notice => @errorMsg # "Please fill all details"
	  end
	end

	#################################
	#  	  Render Forgot Password    #
	#################################
	def forgot_password
	end

	#################################
	#  	  Generate New Pass. Link   #
	#################################
	def request_password
		@user = User.find_by_email(params[:email])
		if @user == nil || @user == ''
			redirect_to "/forgot_password", :notice => "Please enter a valid email"
		else
			@random_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
			@url  = root_url + 'reset_password/' + @random_string
    		User.where(:id => @user.id).update_all(reset_password_token: @random_string)
			@email = UserMailer.forgot_password(@user, @url).deliver
			redirect_to "/forgot_password", :notice => "Please check your email to reset your password"
	    end
	end

	#################################
	#  	 Render Reset Password      #
	#################################

	def reset_password
		@user = User.where(:reset_password_token => params[:reset_password_token])
		if @user.empty?
			redirect_to "/invalid_password_token", :notice => "Invalid password token"
		else
			@token = params[:reset_password_token]
		end
	end

	#################################
	#  	     Update Password        #
	#################################

	def update_password
		password_salt = BCrypt::Engine.generate_salt
        password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
		@user = User.where(:reset_password_token => params[:reset_password_token]).update_all(password_hash: password_hash, password_salt: password_salt)
		puts 'finded'
		puts @user
		redirect_to "/join", :notice => "Your password has been changed, please login"
	end

	#################################
	#  	  Render Invalid Password   #
	#################################

	def invalid_password_token
		
	end

	#################################
	#  	  Render Choose Plan        #
	#################################
	def choose_plan
		@plans = SubscriptionPlan.all
		@paln = User.find(@current_user.id)
		@currentpaln = SubscriptionPlan.find(@paln.plan_id)
		
	end

	#################################
	#  	  Select Payment Method     #
	#################################
	def payment_method
		@plan_details = SubscriptionPlan.find(params[:selected_plan])
		new_price = @plan_details.plan_price * 100
	end

	#################################
	#  Check For Duplicate Email    #
	#################################
	def check_email
		@result = User.find_by_email(params[:email])
		if @result.blank?
			render :json => { :success => false, :user => @result.to_json(:only => [:email]) }
		else
			render :json => { :success => true, :user => 'Email is already taken' }
		end
	end

	private

	  def user_params
	    params.permit(:first_name, :last_name, :email, :password, :plan_id, :user_type, :password_confirmation)
	  end
end
